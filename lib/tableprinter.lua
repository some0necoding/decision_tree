local INDENT_SIZE = 4

local tablePrinter = {}

function tablePrinter.expandType(t, indentLevel, isValue)
    indentLevel = indentLevel or 0
    isValue = isValue or false
    local retString = isValue and "" or string.rep(' ', indentLevel * INDENT_SIZE)

    if type(t) == "number" or
       type(t) == "nil" or
       type(t) == "boolean" or
       type(t) == "function"
    then
        return retString .. tostring(t) .. (isValue and ",\n" or ": ")
    elseif type(t) == "string" then
        t = (isValue and "'" or "") .. t .. (isValue and "'" or "")
        return retString .. t .. (isValue and ",\n" or ": ")
    elseif type(t) == "table" then
        return retString .. tablePrinter.expandTable(t, indentLevel) .. (isValue and ",\n" or ": ")
    end 

    return ""
end

function tablePrinter.expandTable(t, indentLevel)
    indentLevel = (indentLevel or 0) + 1
    local retString = "{\n"

    for key, value in pairs(t) do
        retString = retString .. tablePrinter.expandType(key, indentLevel)
        retString = retString .. tablePrinter.expandType(value, indentLevel, true)
    end

    indentLevel = indentLevel - 1
    retString = retString .. string.rep(' ', indentLevel * INDENT_SIZE) .. "}"
    return retString
end

function tablePrinter.printTable(t, indentSize)
    INDENT_SIZE = indentSize or INDENT_SIZE
    return tablePrinter.expandTable(t)
end

return tablePrinter.printTable
