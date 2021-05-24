---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [24/05/2021 00:00]
---

Audio = {}

---PlaySound
---
--- Reference : N/A
---
---@param Library string
---@param Sound string
---@param IsLooped boolean
---@return nil
---@public
function Audio.PlaySound(Library, Sound, IsLooped)
    local audioId
    if not IsLooped then
        PlaySoundFrontend(-1, Sound, Library, true)
    else
        if not audioId then
            Citizen.CreateThread(function()
                audioId = GetSoundId()
                PlaySoundFrontend(audioId, Sound, Library, true)
                Citizen.Wait(0.01)
                StopSound(audioId)
                ReleaseSoundId(audioId)
                audioId = nil
            end)
        end
    end
end


