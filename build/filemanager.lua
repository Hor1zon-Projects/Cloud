--// Filemanager
-- this is for WIND UI only (in case .ftgs doesn't like add image support to some elements I want-)

local FileManager = {}

FileManager.BaseFolder = "WindUI/Cloud"

function FileManager:SetFile(Name,URL,fileType) --// Really should use promise but eh
    fileType = fileType or ".png" -- I need audio files x3
    local path = FileManager.BaseFolder .. "/Assets/" .. Name .. fileType

    if not isfile(path) then
        --// Download
        local succ,result = pcall(function()
            return game:HttpGet(URL,true)
        end)

        if succ and result then
            writefile(path,result)
        else
            warn("[FILEMANAGER] WARN_FAILED TO DOWNLOAD: ", result)
        end
    end

    if getsynasset then return getsynasset(path) elseif getcustomasset then return getcustomasset(path)
    else
        warn("[FILEMANAGER] Executor does not support custom assets.")
        return nil
    end
end
