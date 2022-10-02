-------------------------------------|
-- Basic MySQL Wrapper for MTA       |
--| Created by Soapbosnia            |
--| 02.10.2022                       |
--| 19:10                            |
-------------------------------------|
local connection = dbConnect(
    "mysql", 
    "dbname=mtadev;host=localhost;port=3306;charset=utf8mb4_general_ci", 
    "root",
    "",
    "share=1"
)

------------------
-- Dependencies --
------------------
function generateWhereClause(data)
    local where=""
    for k,v in pairs(data) do
        where=where.."`"..k.."` = '"..v.."' AND "
    end
    return where:sub(1,-6)
end

function generateSetClause(data)
    local set=""
    for k,v in pairs(data) do
        set=set.."`"..k.."` = '"..v.."', "
    end
    return set:sub(1,-3)
end

function valuesToString(data)
    local values=""
    for k,v in pairs(data) do
        values=values.."`"..k.."` "..v..", "
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

function insert(table,data)
    local columns=""
    local values=""
    for k,v in pairs(data) do
        columns=columns.."`"..k.."`, "
        values=values.."'"..v.."', "
    end
    columns=columns:sub(1,-3)
    values=values:sub(1,-3)
    local query="INSERT INTO `"..table.."` ("..columns..") VALUES ("..values..")"
    return dbExec(connection,query)
end

function select(table, select, where)
    local select=select or "*"
    local query="SELECT `"..select.."` FROM `".. table.."` WHERE "..generateWhereClause(where)
    return dbPoll(dbQuery(connection,query),-1)
end

function selectJoin(table1, table2, joinType, fields, select, where)
    local select=select or "*"
    local query="SELECT `"..select.."` FROM `".. table1.."` "..joinType.." `"..table2.."` ON `"..table1.."`.`"..fields[1].."` = `"..table2.."`.`"..fields[2].."` WHERE "..generateWhereClause(where)
    return dbPoll(dbQuery(connection,query),-1)
end

function update(table, set, where)
    local query="UPDATE `"..table.."` SET "..generateSetClause(set).." WHERE "..generateWhereClause(where)
    return dbExec(connection,query)
end

function delete(table, where)
    local query="DELETE FROM `"..table.."` WHERE "..generateWhereClause(where)
    return dbExec(connection,query)
end