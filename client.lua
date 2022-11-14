-- Created By.SETUP
ESX = nil
local display = false
local keys = 178
local IsPress = false

EMS = 0
POLICE = 0
MECHANICONLINE = 0
FOODPANDA = 0
PlayerOnline = 0

FirstName = {}
LastName = {}
PhoneNumber = {}
JOB = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Wait(7)
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
       
        Wait(1000)
        updatedatafirsttime(data)
        UserProfile(data)

        
       
    end)

end)

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)      
      
       Wait(5000)
       updatedatafirsttime(data)
       UserProfile(data)
   end)
end) 


RegisterNetEvent('profile')
AddEventHandler('profile', function()
   
  
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
        
       
        Wait(1000)        
        UserProfile(data)
         SendNUIMessage({
            type = "update",
            my_id = GetPlayerServerId(PlayerId()),
            my_phonenmumber = PhoneNumber,
            my_fullname = FirstName,
            my_job = JOB,
            my_ping = Ping,
            players = PlayerOnline,
            police = POLICE,
            ems = EMS,
            mc = MECHANICONLINE,
            cf = FOODPANDA
        })
         
     end)
   
   
end)


RegisterNetEvent('update1')
AddEventHandler('update1', function(e,p,m,cf)
   
   
    EMS = e
    POLICE = p    
    MECHANICONLINE = m
    FOODPANDA = cf
    Wait(1000)
    updatedata(e,p,m,cf)
   
   
end)

RegisterNetEvent('playeronline')
AddEventHandler('playeronline', function(allplayer)
   
    PlayerOnline = allplayer
    SendNUIMessage({
        type = "update",       
        players = PlayerOnline,
      
    })
   
end)


Citizen.CreateThread(function()
    while true do
        if ( IsControlPressed(0, keys) and not (ESX == nil) and (IsPress == false) ) then
            IsPress = true
            
            display = not display
            
            TriggerEvent("xscoreboard:display", display)
            IsPress = false
            Citizen.Wait(250)
        end

        Citizen.Wait(10)
    end
end)

AddEventHandler("xscoreboard:display", function(value) 
    SendNUIMessage({
        type = "ui",
        display = value
    })
end)

function updatedata(E,P,M,CF)
    SendNUIMessage({
        type = "update",
        my_id = GetPlayerServerId(PlayerId()),
        my_phonenmumber = PhoneNumber,
        my_fullname = FirstName,
        my_job = JOB,
        my_ping = Ping,
        players = PlayerOnline,
        police = P,
        ems = E,
        mc = M,
        cf = CF
    })
  --  print('From Function '..E,P,M)
end

function updatedatafirsttime(data)
    SendNUIMessage({
        type = "update",
        my_id = GetPlayerServerId(PlayerId()),
        my_phonenmumber = data.my_phonenmumber,
        my_fullname = data.my_fullname,
        my_job = data.my_job,
        my_ping = data.my_ping,
        players = data.PlayerOnline,
        police = data.PoliceConnected,
        ems = data.MedicConnected,
        mc = data.Mechanic,
        cf = data.FOODPANDA
    })
   -- print('From Function '..E,P,M)
end

function UserProfile(data)
    PhoneNumber = data.my_phonenmumber
    FirstName = data.my_fullname
    JOB = data.my_job
    Ping = data.my_ping
    --MECHANICONLINE = data.mc
end