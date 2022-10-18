-------------------------------------|
-- Basic MySQL Wrapper for MTA:SA    |
--| Created by Soapbosnia            |
--| 02.10.2022                       |
--| 19:10                            |
--| Version 2.0 (03.10.2022 | 20:25) |
-------------------------------------|
local connection = dbConnect(
    "mysql", 
    "dbname=mtadev;host=localhost;port=3306;charset=utf8", 
    "root",
    "",
    "share=1"
)

------------------
-- Dependencies --
------------------
function generateWhereClause(data)
    local where=""
    local values={}
    for k,v in ipairs(data) do
        where=where.."`"..v[1].."` = ? AND "
        table.insert(values, v[2])
    end
    return where:sub(1,-6),values
end

function generateSetClause(data)
    local set=""
    local values={}
    for k,v in ipairs(data) do
        set=set.."`"..v[1].."` = ?, "
        table.insert(values, v[2])
    end
    return set:sub(1,-3),values
end

function valuesToString(data)
    local values=""
    for k,v in ipairs(data) do
        values=values.."`"..v[1].."` "..v[2]..", "
    end
    return values:sub(1,-3)
end

-------------
-- Methods --
-------------
function create(table,values)
    local values=valuesToString(values)
    local query="CREATE TABLE IF NOT EXISTS `"..table.."` ("..values..")"
    return dbExec(connection,query)
end

function drop(table)
    local query="DROP TABLE IF EXISTS `"..table.."`"
    return dbExec(connection,query)
end

function insert(tableName,data)
    local columns=""
    local values=""
    local actualValues={}
    for k,v in ipairs(data) do
        columns=columns.."`"..v[1].."`, "
        values=values.."?, "
        table.insert(actualValues, v[2])
    end
    columns=columns:sub(1,-3)
    values=values:sub(1,-3)
    local query="INSERT INTO `"..tableName.."` ("..columns..") VALUES ("..values..")"
    return dbExec(connection,query,unpack(actualValues))
end

function select(table, select, where)
    local select=select or "*"
    local where,values=generateWhereClause(where)
    local query="SELECT "..select.." FROM `".. table.."`"
    if(#values > 0) then
        query = query.." WHERE "..where
    end
    return dbPoll(dbQuery(connection,query,unpack(values)),-1)
end

function update(table, set, where)
    local set,setValues=generateSetClause(set)
    local where,whereValues=generateWhereClause(where)
    local query="UPDATE `"..table.."` SET "..set.." WHERE "..where
    return dbExec(connection,query,unpack(setValues),unpack(whereValues))
end

function delete(table, where)
    local where,values=generateWhereClause(where)
    local query="DELETE FROM `"..table.."` WHERE "..where
    return dbExec(connection,query,unpack(values))
end