-- Created By.SETUP
ESX = nil
MedicConnected = 0
PoliceConnected = 0
PlayerOnline = 0
Mechanic = 0
Foodpanda = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('xscoreboard:server:getdata', function(source, cb)
    local iden = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
        ['@iden'] = iden
    }, function(result)
        if not (result[1] == nil) then
            local data = {}   
            local totol = {}
            local job_label = GetJobLabel(result[1].job, result[1].job_grade)     
            
        
            data =  {
                my_phonenmumber = result[1].phone_number,
                my_fullname = result[1].firstname .. " " .. result[1].lastname,
                my_job = ESX.GetPlayerFromId(source).job.grade_label,
                my_ping = GetPlayerPing(source),
                players = PlayerOnline, 
                MedicConnected = MedicConnected,
                PoliceConnected = PoliceConnected,
                PlayerOnline = PlayerOnline,
                Mechanic = Mechanic,
                Foodpanda = Foodpanda            
               
            }

           
            cb(data)
        else
            cb(nil)
        end
    end)
end)

function GetJobLabel(job_name, job_grade)
    local result = MySQL.Sync.fetchAll('SELECT label FROM job_grades WHERE job_name = @job_name AND grade = @job_grade', {
        ['@job_name'] = job_name,
        ['@job_grade'] = job_grade
    })
    if not (result[1] == nil) then
        return result[1].label
    end
    return nil
end

AddEventHandler('esx:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = ESX.GetPlayerFromId(_source)
  
	if xPlayer.job.name == 'ambulance' then
        MedicConnected = MedicConnected +1
        PlayerOnline = PlayerOnline +1
        TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda) 
        Wait(1000)
        TriggerClientEvent('playeronline',-1,PlayerOnline)   
        elseif xPlayer.job.name == 'police' then
            PoliceConnected = PoliceConnected +1
            PlayerOnline = PlayerOnline +1
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda) 
            Wait(1000)
            TriggerClientEvent('playeronline',-1,PlayerOnline)   
        elseif xPlayer.job.name == 'mechanic' then
            Mechanic = Mechanic +1
            PlayerOnline = PlayerOnline +1
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda) 
            Wait(1000)
            TriggerClientEvent('playeronline',-1,PlayerOnline)   
        elseif xPlayer.job.name == 'foodpanda' then
            Foodpanda = Foodpanda +1
            PlayerOnline = PlayerOnline +1
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda) 
            Wait(1000)
            TriggerClientEvent('playeronline',-1,PlayerOnline) 
                 
        else
            PlayerOnline = PlayerOnline +1 
            Wait(1000)
            TriggerClientEvent('playeronline',-1,PlayerOnline)   
	end

end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)    
    Wait(1000)
   print('Lase Job '..lastJob.name)
   OnlinePlayer(playerId)
   if lastJob.name == "police" then
        PoliceConnected = PoliceConnected -1
        TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)  
        elseif  lastJob.name == "ambulance" then
            MedicConnected = MedicConnected -1 
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)   
        elseif  lastJob.name == "mechanic" then
            Mechanic = Mechanic -1 
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)  
        elseif  lastJob.name == "foodpanda" then
            Foodpanda = Foodpanda -1 
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)  
   end
   

        if ESX.GetPlayerFromId(playerId).job.name == "ambulance" then
            MedicConnected = MedicConnected +1
            Wait(1000)
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
            elseif ESX.GetPlayerFromId(playerId).job.name == "police" then
                PoliceConnected = PoliceConnected +1
                Wait(1000)
                TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
            elseif ESX.GetPlayerFromId(playerId).job.name == "mechanic" then
                Mechanic = Mechanic +1
                Wait(1000)
                TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
            elseif ESX.GetPlayerFromId(playerId).job.name == "foodpanda" then
                Foodpanda = Foodpanda +1
                Wait(1000)
                TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
        end

    
end)

function OnlinePlayer(ID)       
        TriggerClientEvent('profile',ID)
end

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    
    if xPlayer.job.name == "ambulance" then
       PlayerOnline = PlayerOnline -1
       MedicConnected = MedicConnected -1       
       TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
       Wait(1000)
       TriggerClientEvent('playeronline',-1,PlayerOnline)   
    elseif xPlayer.job.name == "police" then
        PlayerOnline = PlayerOnline -1
        PoliceConnected = PoliceConnected -1        
        TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
        Wait(1000)
        TriggerClientEvent('playeronline',-1,PlayerOnline)   
    elseif xPlayer.job.name == "mechanic" then
        PlayerOnline = PlayerOnline -1
        Mechanic = Mechanic -1        
        TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
        Wait(1000)
        TriggerClientEvent('playeronline',-1,PlayerOnline)   
    elseif xPlayer.job.name == "foodpanda" then
        PlayerOnline = PlayerOnline -1
        Foodpanda = Foodpanda -1        
        TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Foodpanda)
        Wait(1000)
        TriggerClientEvent('playeronline',-1,PlayerOnline)  
         
    
    else
       
        PlayerOnline = PlayerOnline-1
        TriggerClientEvent('playeronline',-1,PlayerOnline)  
        print('Drop  PlayerOnline '..PlayerOnline)  
    end
end)

function CheckPlayerByBoseVps() 
	
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
            MedicConnected = MedicConnected + 1
        elseif xPlayer.job.name == 'police' then
            PoliceConnected = PoliceConnected +1
        elseif xPlayer.job.name == 'mechanic' then
            Mechanic = Mechanic +1
        elseif xPlayer.job.name == 'foodpanda' then
            Foodpanda = Foodpanda +1
		end
	end
	
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
            CheckPlayerByBoseVps()           
            TriggerClientEvent('update1',-1, MedicConnected,PoliceConnected,Mechanic,Cheft)
            local xPlayers = ESX.GetPlayers()
             for i=1, #xPlayers, 1 do
                 PlayerOnline = (PlayerOnline + 1)
                 
             end
             Wait(1000)
             TriggerClientEvent('playeronline',-1,PlayerOnline)
             TriggerClientEvent('profile',-1)  
             print(PlayerOnline..' PlayerOnline') 
		end)
	end
end)