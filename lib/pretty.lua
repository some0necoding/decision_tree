local pretty = {}

local INDENT_SIZE = 4
local expandTable

function pretty.expandType(t, indentLevel, indentSize, isValue)
    indentLevel = indentLevel or 0
    indentSize = indentSize or INDENT_SIZE
    isValue = isValue or false

    local retString = ''

    if type(t) == 'number'   or
       type(t) == 'nil'      or
       type(t) == 'boolean'  or
       type(t) == 'function' or
       type(t) == 'thread'   or
       type(t) == 'userdata'
    then
        return retString .. tostring(t)
    elseif type(t) == 'string' then
        if string.find(t, '%b\'\'') or not isValue then
            return retString .. t
        else
            return retString .. string.format('\'%s\'', t)
        end
    elseif type(t) == 'table' then
        return retString .. expandTable(t, indentLevel, indentSize)
    end

    return retString
end

function expandTable(t, indentLevel, indentSize)
    indentLevel = (indentLevel or 0) + 1
    indentSize = indentSize or INDENT_SIZE

    local retString = '{'
    local indentation = string.rep(' ', indentLevel * indentSize)
    local visited = {}

    for i, value in ipairs(t) do
        retString = retString .. '\n' .. indentation .. i .. ': '
        retString = retString .. pretty.expandType(value, indentLevel, indentSize, true) .. ','
        visited[i] = true
    end

    for key, value in pairs(t) do
        if not visited[key] then
            retString = retString .. '\n' .. indentation
            retString = retString .. pretty.expandType(key, indentLevel, indentSize) .. ': '
            retString = retString .. pretty.expandType(value, indentLevel, indentSize, true) .. ','
        end
    end

    -- decrease indentation by 1 to align the closing bracket
    indentation = string.rep(' ', (indentLevel - 1) * indentSize)
    retString = retString .. '\n' .. indentation .. '}'

    return retString
end

function pretty.tostring(v, indentSize)
    return pretty.expandType(v, nil, indentSize, true)
end

function pretty.print(v)
    print(pretty.tostring(v))
end

function pretty.write(fd, v)
    fd:write(pretty.tostring(v))
end

return pretty
