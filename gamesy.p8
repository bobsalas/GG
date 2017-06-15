pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

--notes--

--------general
--this game is meant to play with 128x128 width and height

--it will still work withouth 128x128, but the sprites are not meant to be used at this size

--changing the unchangeable variables may break the game

--"?" may represent a special symbol when found in print

--special symbols will change unless saved in the pico-8 editor
--------

--------code discard
-- function selecthero() --discarded; forgot reason
--  selectnum = 1
--  cls()
--  while (not(btnp(1))) do
--   if (btnp(2)) then
--    selectnum += 1
--   elseif (btnp(3)) then
--    selectnum -= 1
--   end
--   if (selectnum > #herotypes) then
--    selectnum = 1
--   elseif (selectnum <= 0) then
--    selectnum = #herotypes
--   end
--   print("character",gridw*0.25,gridh*0.5,selectnum)
--   spr(herotypes[selectnum][selectnum],gridw*0.75,gridh*0.5,sprw,sprh)
--   print("up/down arrows to select a character",0,gridh-11,7)
--   print("right arrow to proceed",0,gridh-textheight,7)
--  end
-- end

-- function selectvillian() --discarded; forgot reason
--  cls()
--  selectnum = 1
--  while (not(btnp(1))) do
--   if (btnp(2)) then
--    selectnum += 1
--   elseif (btnp(3)) then
--    selectnum -= 1
--   end
--   if (selectnum > #villiantypes) then
--    selectnum = 1
--   elseif (selectnum <= 0) then
--    selectnum = #villiantypes
--   end
--  print("character",gridw*0.25,gridh*0.5,selectnum)
--  spr(herotypes[selectnum][selectnum],gridw*0.75,gridh*0.5,sprw,sprh)
--  print("up/down arrows to select a character",0,gridh-11,7)
--  print("right arrow to proceed",0,gridh-textheight,7)
--  end
-- end

-- function playerchangescreen(num) --discarded; while-loop will only work in update
--  cls()
--  number = num or playerturn
--  while not btnp(5) do
--   print("are you player",gridw*0.25,gridh*0.5,7)
--   print(playerturn,gridw*0.75,gridh*0.5,number)
--   print("'x' if yes",0,gridh-textheight,7)
--  end
-- end

-- function initheroes() --replaced; replaced by the character select phase
--  for j = 0,herocount-1 do --subtracts one because counting starts at 0
--   add(heroes,createhero(j))
--  end
-- end
-- function initvillians()
--  for j = 0,villiancount-1 do --subtracts one because counting starts at 0
--   add(villians,createvillian(j))
--  end
-- end

-- function updateheroes() --discarded/replaced; unncessary because update needs to be specific
--  for i = 1,#heroes do
--   updatehero(i)
--  end
-- end
-- function updatevillians()
--  for i = 1,#villians do
--   updatevillian(i)
--  end
-- end

-- function drawheroes() --replaced; overtaken by drawplayers() and drawplayer(i)
--  for i = 1,#heroes do 
--   drawhero(i)
--  end
-- end
-- function drawhero(i)
--  spr(heroes[i].pic,heroes[i].x,heroes[i].y,heroes[i].w,heroes[i].h)
-- end
-- function drawvillians()
--  for i = 1,#villians do
--   drawvillian(i)
--  end
-- end
-- function drawvillian(i)
--  spr(villians[i].pic,villians[i].x,villians[i].y,villians[i].w,villians[i].h)
-- end

--function drawfog() --replaced; given own init/update/draw for ease of use down the line
--  if (t%fogspeed == 0) then
--   for i = 0,maph-1 do
--    for j = 0,mapw-1 do
--     if (i*tileh != players[playerturn].y) then
--      if (i*tileh == players[playerturn].y + tileh) then
--       if (j*tilew == players[playerturn].x + tilew) then
--        spr(thinfog[flr(rnd(#thinfog))+1],j*tilew,i*tileh,sprw,sprh)
--       elseif (j*tilew == players[playerturn].x - tilew) then
--        spr(thinfog[flr(rnd(#thinfog))+1],j*tilew,i*tileh,sprw,sprh)
--       else
--        spr(thickfog[flr(rnd(#thickfog))+1],j*tilew,i*tileh,sprw,sprh)
--       end
--      elseif (i*tileh == players[playerturn].y - tileh) then
--       if (j*tilew == players[playerturn].x + tilew) then
--        spr(thinfog[flr(rnd(#thinfog))+1],j*tilew,i*tileh,sprw,sprh)
--       elseif (j*tilew == players[playerturn].x - tilew) then
--        spr(thinfog[flr(rnd(#thinfog))+1],j*tilew,i*tileh,sprw,sprh)
--       else
--        spr(thickfog[flr(rnd(#thickfog))+1],j*tilew,i*tileh,sprw,sprh)
--       end
--      else
--       spr(thickfog[flr(rnd(#thickfog))+1],j*tilew,i*tileh,sprw,sprh)
--      end
--     end
--    end
--   end
--  end
-- end

-- h1dead = {68} --replaced; by rip
-- h2dead = {74}
-- h3dead = {96}
-- h4dead = {102}
-- herotypesdead = {h1dead,h2dead,h3dead,h4dead}
--------

--changeable variables--

--------parameters

gridw = 128 --represents the width and height of the screen
gridh = 128

mapw = 8 --reps total tiles horizontally
maph = 8 --reps total tiles vertically

totalgamestates = 3 --reps current gamestates made
gamestate = 0 --reps beginning gamestate

playerturn = 1 --reps beginning turn in game
playerchange = true

selectnum = 1 --this one is changed more often and specifically in the character select phase

instructiondisplay = false

textheight = 5+1 --this is with the space added
textwidth = 3+1 --this is with the space added
--------

--------players
maxplayers = 5
minplayers = 2
villiancount = 1 --this cannot be higher than (maxplayers - 1)

heroap = 3 --hero base values
herohealth = 2 --one hit to injure/two to kill

villianap = 4 --villian base values
villianhealth = 99 --not meant to be killed

h1 = {64,66}
h2 = {68,70}
h3 = {72,74}
h4 = {76,78}
herotypes = {h1,h2,h3,h4}

rip = {160,162}

v1 = {96,98}
villiantypes = {v1}

playerspeed = 60
playermovespeed = 600
--------

--------map
dirt = {8,9,10}
cornreg = {0,1,2,3,4,5,6,7} --represents regular corn sprites

clearfog = {40,41,42,43,44,45,46}
thinfog = {32,33,34,35,36,37,38}
thickfog = {12,13,14}
fogtypes = {clearfog,thinfog,thickfog}

cornspeed = 30

fogspeed = 45
--------

--------objectives
totalgates = 2 --reps how many escapes there are

gateopen = {140,142}
gateclose = {136,138}
gatetypes = {gateopen,gateclose}

extragens = 0 --reps how many generators there will be added

generatoron = {132,134}
generatoroff = {128,130}
generatortypes = {generatoron,generatoroff}

objectivespeed = 60
--------

--unchangebale variables--

--------parameters
tilew = gridw/mapw
tileh = gridh/maph

sprw = tilew/8 --reps length and width of sprite size when made
sprh = tileh/8

sprlw = sprw * 2 -- 4 times larger area than regular sprite
sprlh = sprh * 2

totalescapedplayers = 0

roundnum = 0
--------

--------players
preplayers = {}
players = {}

villianselects = {}
--------

--------map
mappy= {}
--------

--------objectives
gates = {}

generators = {}
--------

--miscellaneous-- --randomly used functions/i am unsure where to place them

--------
function resetgame() --resets all arrays for new game
 totalescapedplayers = 0
 totalkilledplayers = 0
 selectnum = 1
 playerturn = 1
 roundnum = 0
 preplayers = {}
 players = {}
 villianselects = {}
 mappy = {}
 gates = {}
 generators = {}
end

function gamestatechange()
 cls()

 if (gamestate < totalgamestates) then --if gamestate is greater than the total number of possible gamestates'
  gamestate += 1
 else
  resetgame()
  gamestate = 0
 end

 _init()
end

function addhero(i)
 local player = {}
  player.num = i
  player.kind = "hero"
  player.char = herotypes --mainly used for passing info from character select
 return player
end

function addvillian(i)
 local player = {}
  player.num = i
  player.kind = "villian"
  player.char = villiantypes --mainly used for passing info from character select
 return player
end

function checkcollision(x,y)
 checking = true
 for i = 1,#players do
  if (players[i].x == x) and (players[i].y == y) then
   checking = false
  end
 end
 for i = 1,#gates do
  if (gates[i].x == x) and (gates[i].y == y) then
   checking = false
  end
 end
 for i = 1,#generators do
  if (generators[i].x == x) and (generators[i].y == y) then
   checking = false
  end
 end
 return checking
end

function actioncheck(x,y)
 object = false
 for i = 1,#players do
  if (players[i].x == x) and (players[i].y == y) then
   object = "player"
  end
 end
 for i = 1,#gates do
  if (gates[i].x == x) and (gates[i].y == y) then
   object = "gate"
  end
 end
 for i = 1,#generators do
  if (generators[i].x == x) and (generators[i].y == y) then
   object = "generator"
  end
 end
 return object
end

function drawmenu()
 if (players[playerturn].y < gridh/2) then --for bottom bar
  for i = 0,tileh-1 do --creates white bar
   for j = 0,gridw do
    pset(j,(gridh-i),7)
   end
  end

  for i = 0,gridw do
   pset(i,gridh-tileh,0) --creates thin black bar
  end

  print("ap:",1,(gridh-tileh)+2,0)
  print(players[playerturn].ap,25,(gridh-tileh)+2,0)
  print("/",33,(gridh-tileh)+2,0)
  print(players[playerturn].origap,41,(gridh-tileh)+2,0)
  print("health:",(gridw/2)+1,(gridh-tileh)+2,0)
  print(players[playerturn].health,(gridw/2)+41,(gridh-tileh)+2,0)
  print("/",(gridw/2)+49,(gridh-tileh)+2,0)
  print(players[playerturn].orighealth,(gridw/2)+57,(gridh-tileh)+2,0)
 elseif(players[playerturn].y >= gridh/2) then -- for top bar
  for i = 0,tileh-1 do --creates white bar
   for j = 0,gridw do
    pset(j,i,7)
   end
  end

  for i = 0,gridw do
   pset(i,tileh,0) --creates thin black bar
  end

  print("ap:",1,1,0)
  print(players[playerturn].ap,25,1,0)
  print("/",33,1,0)
  print(players[playerturn].origap,41,1,0)
  print("health:",(gridw/2)+1,1,0)
  print(players[playerturn].health,(gridw/2)+41,1,0)
  print("/",(gridw/2)+49,1,0)
  print(players[playerturn].orighealth,(gridw/2)+57,1,0)
 end
end

function drawplayerchange() --covers the screen asking if this is the current player
 if (playerchange == true) then
  cls()
  print("are you player",gridw*0.25,gridh*0.5,7)
  print(players[playerturn].num,gridw*0.75,gridh*0.5,players[playerturn].num)
  print("'x' if yes",0,gridh-textheight,7)
 end
end

function drawpreplayerchange() --covers the screen asking if this is the current player
 if (playerchange == true) then
  cls()
  print("are you player",gridw*0.25,gridh*0.5,7)
  print(preplayers[playerturn].num,gridw*0.75,gridh*0.5,preplayers[playerturn].num)
  print("'x' if yes",0,gridh-textheight,7)
 end
end

function drawinstructiondisplay()
 if (instructiondisplay == true) then
  cls()
  print("hero goals:",0,0,12)
  print("~interact with objects by moving",0,textheight,7)
  print("~repair/heal/move with ap",0,textheight*2,7)
  print("~turn on the generators",0,textheight*3,7)
  print("~escape through the gates",0,textheight*4,7)
  print("~heal other survivors",0,textheight*5,7)
  print("villian goals:",0,gridh*0.5,8)
  print("~interact with objects by moving",0,gridw*0.5+textheight,7)
  print("~break/attack with ap",0,gridw*0.5+textheight*2,7)
  print("~break active generators",0,gridw*0.5+textheight*3,7)
  print("~attack survivors",0,gridw*0.5+textheight*4,7)
  print("press 'x' to return",0,gridh-textheight,7)
 end
end
--------

--creates--

--------map
function initmap()
	for i = 0,maph-1 do --minus one to compensate
  add(mappy,createrow(i))
	end
end

function createrow(i)
 local row = {}
  row.kind = kind or false
  for j = 0,mapw-1 do --minus one to compensate
   add(row,createtile(j,i))
  end
 return row
end

function createtile(j,i,x,y,w,h,kind)
	local tile = {}
  tile.x = x or j*tilew
  tile.y = y or i*tileh
  tile.w = w or sprw
  tile.h = h or sprh
  tile.kind = kind or false
  tile.dirt = dirt[flr(rnd(#dirt))+1]
  tile.fog = thickfog[flr(rnd(#thickfog))+1]
  tile.pic = cornreg[flr(rnd(#cornreg))+1]
 return tile
end
--------

--------players
function initplayers()
 for i = 1,#preplayers do --the if statement belows mean it will crash if the kind is not one or the other
  if (preplayers[i].kind == "hero") then --"hero" gets replaced with an array of herotype attributes
   add(players,createhero(i,false,false,false,false,preplayers[i].char))
  elseif (preplayers[i].kind == "villian") then--"villian" gets replaced with an array of villian type attributes
   add(players,createvillian(i,false,false,false,false,preplayers[i].char))
  end
 end
end

function createhero(i,x,y,w,h,char,pic,ap,mp,vis,health)
 paramcheck = false
 local hero = {}
  while (paramcheck == false) do
   hero.x = x or flr(rnd(mapw)/2)*tilew --spawns on left side of map
   hero.y = y or flr(rnd(mapw))*tilew
   hero.w = w or sprw
   hero.h = h or sprh
   hero.char = char or herotypes[flr(rnd(#herotypes))+1]
   hero.pic = hero.char[flr(rnd(#hero.char))+1] --this retrieves from "hero.char" above
   hero.ap = ap or heroap
   hero.health = health or herohealth
   hero.origap = hero.ap --to reset values after a turn
   hero.orighealth = hero.health
   hero.num = i
   hero.id = "hero"
   hero.status = "alive"
   paramcheck = checkcollision(hero.x,hero.y)
  end
 return hero
end

function createvillian(i,x,y,w,h,char,pic,ap,health)
 paramcheck = false
 local villian = {}
  while (paramcheck == false) do
   villian.x = x or ((mapw-1)*tilew) - flr(rnd(mapw)/2)*tilew --spwans on right side of map
   villian.y = y or (i-1)*tileh
   villian.w = w or sprw
   villian.h = h or sprh
   villian.char = char or villiantypes[flr(rnd(#villiantypes))+1]
   villian.pic = villian.char[flr(rnd(#villian.char))+1] --this retrieves from "villian.char" above
   villian.ap = ap or villianap
   villian.health = health or villianhealth
   villian.origap = villian.ap --to reset values after a turn
   villian.orighealth = villian.health
   villian.num = i
   villian.id = "villian"
   villian.status = "alive"
   paramcheck = checkcollision(villian.x,villian.y)
  end
 return villian
end
--------

--------objectives
function initobjectives()
 initgates()
 initgenerators()
end

function initgates()
 for i = 1, totalgates do
  add(gates,initgate(i))
 end
end

function initgate(i)
 paramcheck = false
 local gate = {}
  while (paramcheck == false) do
   chance = rnd(1) --to decide whether the gate is on the left or the right
   if (chance > 0.5) then
    gate.x = (flr(rnd(2)))*(gridw-tilew) --(flr(rnd(2))) produces 0 or 1
    gate.y = (flr(rnd(maph)))*(tileh)
    if (gate.x == 0) then
     gate.placement = "left"
    else
     gate.placement = "right"
    end
   else
    gate.x = (flr(rnd(mapw)))*(tilew)
    gate.y = (flr(rnd(2)))*(gridh-tileh) --(flr(rnd(2))) produces 0 or 1
    if (gate.y == 0) then
     gate.placement = "top"
    else
     gate.placement = "bottom"
    end
   end
   gate.w = sprw
   gate.h = sprh
   gate.status = status or "closed"
   gate.char = gateclose
   gate.pic = gate.char[flr(rnd(#gate.char))+1]
   paramcheck = checkcollision(gate.x,gate.y)
  end
 return gate 
end

function initgenerators()
 for i = 1, (#players + extragens) do
  add(generators,initgenerator(i))
 end
end

function initgenerator(i,x,y,w,h,status)
 paramcheck = false
 local generator = {}
  while(paramcheck == false) do
   generator.x = x or (flr(mapw*0.75)*tilew)-(flr(rnd(mapw*0.5))*tilew) --makes spawn in the center in regards to x
   generator.y = y or (flr(rnd(maph)))*(tileh)
   generator.w = w or sprw
   generator.h = h or sprh
   generator.status = status or "off"
   generator.char = generatoroff
   generator.pic = generator.char[flr(rnd(#generator.char))+1]
   paramcheck = checkcollision(generator.x,generator.y)
  end
 return generator
end
--------

--updates--

--------map
function updatemap()
 for i = 1,#mappy do
  updaterow(i)
 end
end

function updaterow(i)
 for j = 1,#mappy[i] do
  updatetile(j,i)
 end
end

function updatetile(j,i) --creates fog for each tile in regard to current player
 if (t%fogspeed == 0) then
  if ((i-1)*tileh != players[playerturn].y) then
   if ((i-1)*tileh == players[playerturn].y + tileh) then
    if ((j-1)*tilew == players[playerturn].x + tilew) then
     mappy[i][j].fog = thinfog[flr(rnd(#thinfog))+1]
    elseif ((j-1)*tilew == players[playerturn].x - tilew) then
     mappy[i][j].fog = thinfog[flr(rnd(#thinfog))+1]
    elseif ((j-1)*tilew != players[playerturn].x) then
     mappy[i][j].fog = thickfog[flr(rnd(#thickfog))+1]
    else
     mappy[i][j].fog = clearfog[flr(rnd(#clearfog))+1]
    end
   elseif ((i-1)*tileh == players[playerturn].y - tileh) then
    if ((j-1)*tilew == players[playerturn].x + tilew) then
     mappy[i][j].fog = thinfog[flr(rnd(#thinfog))+1]
    elseif ((j-1)*tilew == players[playerturn].x - tilew) then
     mappy[i][j].fog = thinfog[flr(rnd(#thinfog))+1]
    elseif ((j-1)*tilew != players[playerturn].x) then
     mappy[i][j].fog = thickfog[flr(rnd(#thickfog))+1]
    else
     mappy[i][j].fog = clearfog[flr(rnd(#clearfog))+1]
    end
   else
    mappy[i][j].fog = thickfog[flr(rnd(#thickfog))+1]
   end
  else
   mappy[i][j].fog = clearfog[flr(rnd(#clearfog))+1]
  end
 end

 if (t%cornspeed == 0) then
  mappy[i][j].pic = cornreg[flr(rnd(#cornreg))+1]
 end
end
--------

--------players
function updateplayers()
 if (playerchange == false) then
  if (players[playerturn].ap > 0) then--basic movement for all players
   if (btnp(0)) and (players[playerturn].x > 0) then
    if (checkcollision(players[playerturn].x - tilew,players[playerturn].y)) then --to move left/these are horrendously long
     for i = 1,tilew*playermovespeed do --for animation
      if (i % playermovespeed == 0) then
       players[playerturn].x -= 1
      end
     end
     players[playerturn].ap -= 1
     sfx(63)
    else
     if (actioncheck(players[playerturn].x - tilew,players[playerturn].y) == "gate") then
      for i = 1,#gates do
       if (gates[i].x == players[playerturn].x - tilew) and (gates[i].y == players[playerturn].y) then
        if (gates[i].status == "open") then      
         if (players[playerturn].id == "hero") then
          players[playerturn].status = "escaped"
          players[playerturn].x -= tilew
          playerchange = true
          totalescapedplayers += 1
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x - tilew,players[playerturn].y) == "player") then
      for i = 1,#players do
       if (players[i].x == players[playerturn].x - tilew) and (players[i].y == players[playerturn].y) then
        if (players[playerturn].id == "villian") then
         if (players[i].id == "hero") then
          players[i].health -= 1
          players[playerturn].ap -= 2
          if (players[i].health <= 0) then
           players[i].status = "dead"
           players[i].x += 1 --corrupting from the map allows for movement over the grave
          end
          sfx(55)
         end
        elseif (players[playerturn].id == "hero") then
         if (players[i].id == "hero") then
          if (players[i].health < players[i].orighealth) then
           players[i].health += 1
           players[playerturn].ap -= 1
          end
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x - tilew,players[playerturn].y) == "generator") then
      for i = 1,#generators do
       if (generators[i].x == players[playerturn].x - tilew) and (generators[i].y == players[playerturn].y) then
        if (players[playerturn].id == "villian") then
         if (generators[i].status != "off") then
          generators[i].status = "off"
          players[playerturn].ap -= 1
         end
        elseif (players[playerturn].id == "hero") then
         if (generators[i].status != "on") then
          generators[i].status = "on"
          players[playerturn].ap -= 1
          sfx(54)
         end
        end
       end
      end
     end
    end
   elseif (btnp(1)) and (players[playerturn].x < gridw-tilew) then
    if (checkcollision(players[playerturn].x + tilew,players[playerturn].y)) then --to move right
     for i = 1,tilew*playermovespeed do --for animation
      if (i % playermovespeed == 0) then
       players[playerturn].x += 1
      end
     end
     players[playerturn].ap -= 1
     sfx(63)
    else
     if (actioncheck(players[playerturn].x + tilew,players[playerturn].y) == "gate") then
      for i = 1,#gates do
       if (gates[i].x == players[playerturn].x + tilew) and (gates[i].y == players[playerturn].y) then
        if (gates[i].status == "open") then      
         if (players[playerturn].id == "hero") then
          players[playerturn].status = "escaped"
          players[playerturn].x += tilew
          playerchange = true
          totalescapedplayers += 1
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x + tilew,players[playerturn].y) == "player") then
      for i = 1,#players do
       if (players[i].x == players[playerturn].x + tilew) and (players[i].y == players[playerturn].y) then
        if (players[playerturn].id == "villian") then
         if (players[i].id == "hero") then
          players[i].health -= 1
          players[playerturn].ap -= 2
          if (players[i].health <= 0) then
           players[i].status = "dead"
           players[i].x += 1 --corrupting from the map allows for movement over the grave
          end
          sfx(55)
         end
        elseif (players[playerturn].id == "hero") then
         if (players[i].id == "hero") then
          if (players[i].health < players[i].orighealth) then
           players[i].health += 1
           players[playerturn].ap -= 1
          end
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x + tilew,players[playerturn].y) == "generator") then
      for i = 1,#generators do
       if (generators[i].x == players[playerturn].x + tilew) and (generators[i].y == players[playerturn].y) then
        if (players[playerturn].id == "villian") then
         if (generators[i].status != "off") then
          generators[i].status = "off"
          players[playerturn].ap -= 1
         end
        elseif (players[playerturn].id == "hero") then
         if (generators[i].status != "on") then
          generators[i].status = "on"
          players[playerturn].ap -= 1
          sfx(54)
         end
        end
       end
      end
     end
    end
   elseif (btnp(2)) and (players[playerturn].y > 0) then
    if (checkcollision(players[playerturn].x,players[playerturn].y - tileh)) then --to move up
     for i = 1,tilew*playermovespeed do --for animation
      if (i % playermovespeed == 0) then
       players[playerturn].y -= 1
      end
     end
     players[playerturn].ap -= 1
     sfx(62)
    else
     if (actioncheck(players[playerturn].x,players[playerturn].y - tileh) == "gate") then
      for i = 1,#gates do
       if (gates[i].x == players[playerturn].x) and (gates[i].y == players[playerturn].y - tileh) then
        if (gates[i].status == "open") then      
         if (players[playerturn].id == "hero") then
          players[playerturn].status = "escaped"
          players[playerturn].y -= tileh
          playerchange = true
          totalescapedplayers += 1
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x,players[playerturn].y - tileh) == "player") then
      for i = 1,#players do
       if (players[i].x == players[playerturn].x) and (players[i].y == players[playerturn].y - tileh) then
        if (players[playerturn].id == "villian") then
         if (players[i].id == "hero") then
          players[i].health -= 1
          players[playerturn].ap -= 2
          if (players[i].health <= 0) then
           players[i].status = "dead"
           players[i].x += 1 --corrupting from the map allows for movement over the grave
          end
          sfx(55)
         end
        elseif (players[playerturn].id == "hero") then
         if (players[i].id == "hero") then
          if (players[i].health < players[i].orighealth) then
           players[i].health += 1
           players[playerturn].ap -= 1
          end
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x,players[playerturn].y - tileh) == "generator") then
      for i = 1,#generators do
       if (generators[i].x == players[playerturn].x) and (generators[i].y == players[playerturn].y - tileh) then
        if (players[playerturn].id == "villian") then
         if (generators[i].status != "off") then
          generators[i].status = "off"
          players[playerturn].ap -= 1
         end
        elseif (players[playerturn].id == "hero") then
         if (generators[i].status != "on") then
          generators[i].status = "on"
          players[playerturn].ap -= 1
          sfx(54)
         end
        end
       end
      end
     end
    end
   elseif (btnp(3)) and (players[playerturn].y < gridh-tileh) then
    if (checkcollision(players[playerturn].x,players[playerturn].y + tileh)) then --to move down
     for i = 1,tilew*playermovespeed do --for animation
      if (i % playermovespeed == 0) then
       players[playerturn].y += 1
      end
     end
     players[playerturn].ap -= 1
     sfx(62)
    else
     if (actioncheck(players[playerturn].x,players[playerturn].y + tileh) == "gate") then
      for i = 1,#gates do
       if (gates[i].x == players[playerturn].x) and (gates[i].y == players[playerturn].y + tileh) then
        if (gates[i].status == "open") then      
         if (players[playerturn].id == "hero") then
          players[playerturn].status = "escaped"
          players[playerturn].y += tileh
          playerchange = true
          totalescapedplayers += 1
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x,players[playerturn].y + tileh) == "player") then
      for i = 1,#players do
       if (players[i].x == players[playerturn].x) and (players[i].y == players[playerturn].y + tileh) then
        if (players[playerturn].id == "villian") then
         if (players[i].id == "hero") then
          players[i].health -= 1
          players[playerturn].ap -= 2
          if (players[i].health <= 0) then
           players[i].status = "dead"
           players[i].x += 1 --corrupting from the map allows for movement over the grave
          end
          sfx(55)
         end
        elseif (players[playerturn].id == "hero") then
         if (players[i].id == "hero") then
          if (players[i].health < players[i].orighealth) then
           players[i].health += 1
           players[playerturn].ap -= 1
          end
         end
        end
       end
      end
     elseif (actioncheck(players[playerturn].x,players[playerturn].y + tileh) == "generator") then
      for i = 1,#generators do
       if (generators[i].x == players[playerturn].x) and (generators[i].y == players[playerturn].y + tileh) then
        if (players[playerturn].id == "villian") then
         if (generators[i].status != "off") then
          generators[i].status = "off"
          players[playerturn].ap -= 1
         end
        elseif (players[playerturn].id == "hero") then
         if (generators[i].status != "on") then
          generators[i].status = "on"
          players[playerturn].ap -= 1
          sfx(54)
         end
        end
       end
      end
     end
    end
   end
  elseif (players[playerturn].ap <= 0) then --need to be fixed if perks are wanted in the future
   players[playerturn].ap = players[playerturn].origap
   
   playerturn += 1
   
   if (playerturn > #players) then
    playerturn = 1 --brings it back to first person
    roundnum += 1 --round determination
   end

   playerchange = true
  
   sfx(56)
  end
 elseif (playerchange == true) then
  if (btnp(5)) then
   playerchange = false
   sfx(57)
  end
 end

 activeheroes = 0
 for i = 1,#players do -- code()
  if (players[i].id == "hero") then --this if statement means it will crash if the kind is not one or the other.
   updatehero(i)

   if (players[i].status == "alive") then
    activeheroes += 1
   end
  elseif (players[i].id == "villian") then
   updatevillian(i)
  end
 end

 if (activeheroes <= 0) then
  gamestatechange()
 end
end

function updatehero(i)
 if (t % playerspeed == 0) then
  players[i].pic = players[i].char[flr(rnd(#players[i].char))+1]
 end

 if (players[i].status == "dead") then
  players[i].ap = 0
  players[i].origap = 0
  players[i].health = 0
  players[i].orighealth = 0
  players[i].char = rip

  if (players[i] == players[playerturn]) then
   playerturn += 1

   if (playerturn > #players) then
    playerturn = 1 --brings it back to first person
    roundnum += 1 --round determination
   end
  end
 elseif (players[i].status == "escaped") then
  players[i].ap = 0
  players[i].origap = 0
  players[i].health = 0
  players[i].orighealth = 0

  if (players[i] == players[playerturn]) then
   playerturn += 1

   if (playerturn > #players) then
    playerturn = 1 --brings it back to first person
    roundnum += 1 --round determination
   end
  end
 end
end

function updatevillian(i)
 if (t % playerspeed == 0) then
  players[i].pic = players[i].char[flr(rnd(#players[i].char))+1]
 end
 
end 
--------

--------objectives
function updateobjectives()
 updategates()
 updategenerators()
end

function updategates()
 for i = 1,#gates do
  updategate(i)
 end
end

function updategate(i)
 if (t % objectivespeed == 0) then
  if (gates[i].status == "closed") then
   gates[i].char = gateclose
  elseif (gates[i].status == "open") then
   gates[i].char = gateopen
  end

  gates[i].pic = gates[i].char[flr(rnd(#gates[i].char))+1] --selects new gen pic 
 end
end

function updategenerators()
 for i = 1, #generators do
  updategenerator(i)
 end
end

function updategenerator(i)
 if (t % objectivespeed == 0) then
  if (generators[i].status == "off") then
   generators[i].char = generatoroff
   gates[flr(i/#generators)+1].status = "closed"
  elseif (generators[i].status == "on") then
   generators[i].char = generatoron
   gates[flr(i/#generators)+1].status = "open"
  end

  generators[i].pic = generators[i].char[flr(rnd(#generators[i].char))+1] --selects new gen pic
 end
end
--------

--draws--

--------map
function drawmap()
 for i = 1,#mappy do
  drawrow(i)
 end
end

function drawrow(i)
 for j = 1,#mappy[i] do
  drawtile(j,i)
 end
end

function drawtile(j,i)
 spr(mappy[i][j].dirt,mappy[i][j].x,mappy[i][j].y,mappy[i][j].w,mappy[i][j].h)
end

function drawcornfield() --seperated to draw over
 for i = 1,#mappy do
  drawcornrow(i)
 end
end

function drawcornrow(i)
 for j = 1,#mappy[i] do
  drawcorn(j,i)
 end
end

function drawcorn(j,i)
 spr(mappy[i][j].pic,mappy[i][j].x,mappy[i][j].y+tileh/2,mappy[i][j].w/2,mappy[i][j].h/2) --"mappy[i][j].w/2,mappy[i][j].h/2":over 2 because corn sprites are smaller
 spr(mappy[i][j].pic,mappy[i][j].x+tilew/2,mappy[i][j].y+tileh/2,mappy[i][j].w/2,mappy[i][j].h/2)
end

function drawfog() --seperated to draw over
 for i = 1,#mappy do
  drawfogrow(i)
 end
end

function drawfogrow(i)
 for j = 1,#mappy[i] do
  drawfogtile(j,i)
 end
end

function drawfogtile(j,i)
 spr(mappy[i][j].fog,mappy[i][j].x,mappy[i][j].y,mappy[i][j].w,mappy[i][j].h)
end
--------

--------players
function drawplayers()
 for i = 1,#players do
  drawplayer(i)
 end
end

function drawplayer(i)
 spr(players[i].pic,players[i].x,players[i].y,players[i].w,players[i].h)
end
--------

--------objectives
function drawobjectives()
 drawgates()
 drawgenerators()
end

function drawgates()
 for i = 1,#gates do
  drawgate(i)
 end
end

function drawgate(i)
 spr(gates[i].pic,gates[i].x,gates[i].y,gates[i].w,gates[i].h)
end

function drawgenerators()
 for i = 1,#generators do
  drawgenerator(i)
 end
end

function drawgenerator(i)
 spr(generators[i].pic,generators[i].x,generators[i].y,generators[i].w,generators[i].h)
end
--------

--main()--

--------title
function titleinit()
 playercount = minplayers
end

function titleupdate()
 if (instructiondisplay == true) then
  if (btnp(5)) then
   instructiondisplay = false
  end
 else 
  if (btnp(2)) and (playercount < maxplayers) then
   playercount += 1
  elseif (btnp(3)) and (playercount > minplayers) then
   playercount -= 1
  end

  if (btnp(0)) then
   instructiondisplay = true
  elseif (btnp(1)) then
   herocount = playercount - villiancount

   gamestatechange()
  end
 end
end

function titledraw()
 cls()
 spr(192,(gridw/2 - tilew*2),tileh,sprlw,sprlh) --"tilew*2":done to subtract the width of the large sprite
 spr(196,gridw/2,tileh,sprlw,sprlh)
 print("number of players",gridw*0.2,gridh*0.75,7)
 print(playercount,gridw*0.8,gridh*0.75,playercount)
 print("up/down arrows to change number",0,gridh-textheight*2,7) --"gridh - 11":done to allow for space of text
 print("right arrow to proceed",0,gridh-textheight,7) --"gridh - 5":done to allow for space of text
 drawinstructiondisplay()
end
--------

--------character select
function charselectinit()
 for i = 1,villiancount do
  add(villianselects,flr(rnd(playercount))+1)
 end

 for i = 1,playercount do
  herocheck = true
  for j = 1, #villianselects do
   if (villianselects[j] == i) then
    herocheck = false
   end
  end

  if (herocheck == false) then
   add(preplayers,addvillian(i))
  else
   add(preplayers,addhero(i))
  end
 end
end

function charselectupdate()
 if (playerchange == false) then
  if (preplayers[playerturn].char == herotypes) then
   if (btnp(2)) then
    selectnum += 1
   elseif (btnp(3)) then
    selectnum -= 1
   end

   if (selectnum > #herotypes) then
    selectnum = 1
   elseif (selectnum < 1) then --"1": reps minimimum types
    selectnum = #herotypes
   end
  elseif (preplayers[playerturn].char == villiantypes) then
   if (btnp(2)) then
    selectnum += 1
   elseif (btnp(3)) then
    selectnum -= 1
   end

   if (selectnum > #villiantypes) then
    selectnum = 1
   elseif (selectnum < 1) then --"1": reps minimimum types
    selectnum = #villiantypes
   end  
  end

  if (btnp(1)) then
   preplayers[playerturn].char = preplayers[playerturn].char[selectnum] --makes ".char" more specific

   playerturn += 1 --goes to next player
   selectnum = 1

   if (playerturn > #preplayers) then
    playerturn = 1
    gamestatechange()
   end

   playerchange = true

   sfx(56)
  end
 else
  if (btnp(5)) then
   playerchange = false
   sfx(57)
  end
 end
end

function charselectdraw()
 cls()
 spr(preplayers[playerturn].char[selectnum][1],gridw*0.75,gridh*0.5,sprw,sprh) --chose "[1]" because it will select the default sprite
 print("you are a",gridw*0.2,gridh*0.25,7)
 print(preplayers[playerturn].kind,gridw*0.5,gridh*0.25,playerturn)
 print("player",gridw*0.1,gridh*0.5,playerturn)
 print(playerturn,gridw*0.4,gridh*0.5,playerturn)
 print("up/down arrows to change",0,gridh-textheight*2,7)
 print("right arrow to proceed",0,gridh-textheight,7)
 drawpreplayerchange()
end
--------

--------game
function gameinit()
 t = 0 --for track of frames

 music(0) --recommend to turn off when testing

 initmap()
 initplayers()
 initobjectives()
end

function gameupdate()
 t+=1

 updatemap()
 updateplayers()
 updateobjectives()
end

function gamedraw()
 cls()
 drawmap()
 drawplayers()
 drawobjectives()
 drawcornfield() --seperated from map for depth effect
 drawfog()                          
 drawmenu()
 drawplayerchange()
end
--------

--------gameover
function gameoverinit()
 totalkilledplayers = herocount - totalescapedplayers
end

function gameoverupdate()
 if (btnp(5)) then
  gamestatechange()
 end
end

function gameoverdraw()
 cls()
 print("game over",gridw*0.33,0,7)
 print(totalescapedplayers,gridw*0.25,gridh*0.40,12)
 print("players survived",gridw*0.33,gridh*0.40,12)
 print(totalkilledplayers,gridw*0.25,gridh*0.60,8)
 print("players died",gridw*0.33,gridh*0.60,8)
 print("'x' to play again",0,gridh-textheight,7)
end
--------

--------core
function _init()
 if (gamestate == 2) then --prioritized for speed
  gameinit()
 elseif (gamestate == 0) then
  titleinit()
 elseif (gamestate == 1) then
  charselectinit()
 elseif (gamestate == 3) then
  gameoverinit()
 end
end

function _update60() --_update60() for increased frame rate
 if (gamestate == 2) then
  gameupdate()
 elseif (gamestate == 0) then --prioritized for speed
  titleupdate()
 elseif (gamestate == 1) then
  charselectupdate()
 elseif (gamestate == 3) then
  gameoverupdate()
 end
end

function _draw()
 if (gamestate == 2) then
  gamedraw()
 elseif (gamestate == 0) then --prioritized for speed
  titledraw()
 elseif (gamestate == 1) then
  charselectdraw()
 elseif (gamestate == 3) then
  gameoverdraw()
 end
end
--------

__gfx__
b03a0b300b00b00003b00b30b000b030b03b00b3bb0003b0b3000b30b00bb00b44444044444444404444444440444440777666555775555ddd65577777775775
0333ba33b0b33ab0303a303330b3330003000330003a300000303030a330a330404444440444444440444404444446445557757775d5ddd677dd755555575555
0a3003300000330003330000300033ab03ab30300b033000b3a3ab03300330004444644444644404444444444444440466777777555666675556dd5577dd5577
033ab03a00003ab00a30000a30003a300330003a300a300b003330030000300b4544544444454444404045444474440477ddd555777557766665575555677ddd
b033b033b0ba3300b3300b33000b0300b30b003300b33003b00303a3a3b03a30444044440444444444444444044404045d555555557777556577555665555555
03300330000330bb033a3003ab0ba30333a03a3a00033a3003a30b33303a33004444444444444404644444444444444455556777777757555ddd666555655655
0030003000003300003300b33000333003b0033b00003300003330033b03300004444445444044444444440444404444667775555755557776566dd555657ddd
00b00030000030000030000300000300030000300000300000030003000030004464404444444464445044444444444777656657766555dd766dd5555777555d
0000000000000000000000000000000000000000000000000000000000000000444444444044404404744404444044446555557d555d5556ddd66ddddddddddd
00000000000000000000000000000000000000000000000000000000000000005044444444444445444444444644444455dd77555555565566ddd75555555d66
000000000000000000000000000000000000000000000000000000000000000044444404444444440444404444444444dd57555556667777555555555555dd66
0000000000000000000000000000000000000000000000000000000000000000444444444444400444404444044440445575665665775d55666657dddddd5555
00000000000000000000000000000000000000000000000000000000000000004444540444644444474444444454444467657757775dd565dddddd777d777555
000000000000000000000000000000000000000000000000000000000000000044044444044404444444404444444004755577777dd5667766555555d7665555
0000000000000000000000000000000000000000000000000000000000000000444444444446444404444444044044445577555557777755dddddddddddd5555
00000000000000000000000000000000000000000000000000000000000000000446440444444440445444440444444077d55555577577775666dd555555dddd
7060005ddddd5775666666007777777d7777666dd600d00dd6600700000555770000000000600000000000000000000000000000000000000000000000000000
60666dd770000007ddd7770000000000000077770066ddd67777667555d777770000000000000000000000000000050000000005000000000000000000000000
506dd700dddd000d7700500ddd0ddd770dddd00d77777700000000d0000667007000000000000000000000000000000000000000000000000600000000060000
d0000d067777dd005500066660007777dd0000000777700600005000605005d70000000000000000007000000000000000500000000d00600600000000000000
00d00000000077500666000000007770dd0777777d0dd77777d0766d000000770000000000000000000000000700000000000000000000000000000000000000
dd000000d5776dd70770770000d07006677d00000d066770007d6600d0000075000000d00000700000000000000000000000000000000000000000000000d000
00600d66676dd07d0ddddd5dd007007d055d5556dd777ddd0060d00000d000d00000000000000000000000000000070000000000000000000000005500000000
6dd0070000d677d5070660d00000dd76000000000055000000000077700000700000000000000000000000000000070000000000d00000000000000000000000
d0000d7000070d50077700000000067000000000007000007007777077d06707000000000000000000000000d000000000000000000000000000000000000000
dd0d00070076d667d700000060665777ddd70dd00500770000000707067d667606000000050000000005000000000000000000000070000000700000d0070000
d677d00577dd077000d0000000006670077000ddd777777700000d700000d6670000000000000000000000000d00000000000000000000000070000000000000
6700ddd7dd7d00d006dd77776dd775760d000000000dd60d000007dd0006d00600000000000000600000000000000000000d0000000006000000000000000000
d700677dd67766666d007d770060000050d77777707000d0d7000077ddd750dd0000000000000000000000000000000000000000000000000000000000000600
750070d777667000000707dd77006dd77777ddd000d777007d7ddd7770dd70000007000000700000000000000000600000000007000000000050000700000000
0070700660007077d6767500d077600d7dd66666657777777760076dd700d7700000000000700000000660000000000500000000000000006000000700000000
6777d0005770dd76d76700000ddd777dd777777777dd066070007dd0007770d700d0000000000000000000000000000000000000000000d00000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000007777000000000000000000000000000066660000000000000000000000000000dddd000000000000000000000000000055550000000000000000000000
0000007777000000000000777700000000000066660000000000006666000000000000dddd000000000000dddd00000000000055550000000000005555000000
0000007777000000000000777700000000000066660000000000006666000000000000dddd000000000000dddd00000000000055550000000000005555000000
00000007700000000000007777000000000000066000000000000066660000000000000dd0000000000000dddd00000000000005500000000000005555000000
00007777777700000000000770000000000066666666000000000006600000000000dddddddd00000000000dd000000000005555555500000000000550000000
0007777777777000000077777777000000066666666660000000666666660000000dddddddddd0000000dddddddd000000055555555550000000555555550000
007707777770770000077777777770000066066666606600000666666666600000dd0dddddd0dd00000dddddddddd00000550555555055000005555555555000
0000007777000000007707777770770000000066660000000066066666606600000000dddd00000000dd0dddddd0dd0000000055550000000055055555505500
0000007777000000000000777700000000000066660000000000006666000000000000dddd000000000000dddd00000000000055550000000000005555000000
000007777770000000000077770000000000066666600000000000666600000000000dddddd00000000000dddd00000000000555555000000000005555000000
000007700770000000000777777000000000066006600000000006666660000000000dd00dd0000000000dddddd0000000000550055000000000055555500000
000007700770000000007770077700000000066006600000000066600666000000000dd00dd000000000ddd00ddd000000000550055000000000555005550000
000007700770000000007700007700000000066006600000000066000066000000000dd00dd000000000dd0000dd000000000550055000000000550000550000
000007700770000000077700007770000000066006600000000666000066600000000dd00dd00000000ddd0000ddd00000000550055000000005550000555000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000888800000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000800800000070000088880000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000888800000770000080080000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000088000000700000088880000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088888888007700000008800000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888800888807000008888888800770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08808800880885000088880088880700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000888800055000880880088088500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000888800050000000088880005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008888880000000000088880005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008800880000000000888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008800880000000008880088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008800880000000008800008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008800880000000088800008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000008888888888888888888888888888888888888888888888888888888888888888
0000080000000000000000000000000000000b00000000000000000000000000833636363336333883363636333633388bb6b6b6bbb6bbb88336363633363338
000088800000000000000800000000000000bbb00000000000000b0000000000836636366366636883663636636663688b66b6b66b666b688366363663666368
0000050000000000000088800000000000000500000000000000bbb000000000833663666366636883366366636663688bb66b666b666b688336636663666368
0000050000000000000005000000000000000500000000000000050000000000836636366366636883663636636663688b66b6b66b666b688366363663666368
0000050000000000000005000000000000000500000000000000050000000000833636363336636883363636333663688bb6b6b6bbb66b688336363633366368
000008888800000000000500000000000000088888000000000005000000000086ddddddddddd66886ddddddddddd66886000000000006688600000000000668
00008757578000000000088888000000000087575780000000000888880000008655555555555668865555555555566886000000000006688600000000000668
000885555588800000008757578000000008855555888000000087575780000086ddddddddddd66886ddddddddddd66886000000000006688600000000000668
00087757577880000008855555888000000877575778b00000088555558880008655555555555668865555555555566886000000000006688600000000000668
000886666688800000087757577880000008866666888000000877575778b00086ddddddddddda9a86ddddddddddda9a8600000000000a9a8600000000000a9a
00008888888000000008866666888000000088888880000000088666668880008655555555555989865555555555590986000000000009b98600000000000909
000005000500000000008888888000000000050005000000000088888880000086ddddddddddda9a86ddddddddddda9a8600000000000a9a8600000000000a9a
00005500055000000000550005500000000055000550000000005500055000008655555555555668865555555555566886000000000006688600000000000668
000550000055000000055000005500000005500000550000000550000055000086ddddddddddd66886ddddddddddd66886000000000006688600000000000668
00000000000000000000000000000000000000000000000000000000000000008655555555555668865555555555566886000000000006688600000000000668
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00005555555500000000555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00055555555550000005555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555555555555000055555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00577757775777000057775777577700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00575755755757000057575575575700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00577755755777000057775575577700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00577555755755000057755575575500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00575757775755000057575777575500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08885855855558000055585585558500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888888888888000888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888888888888800888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777777777777700000000000000000777777777777777000000000000000000000000000000000000000000000000000000000000000000000000
00000000778888888888888770000000000000007711111111111117700000000000000000000000000000000000000000000000000000000000000000000000
00000007788888888888888877000000000000077111111111111111770000000000000000000000000000000000000000000000000000000000000000000000
00000077887777777777777887700000000000771177777777777771177000000000000000000000000000000000000000000000000000000000000000000000
00000778877000000000007788770000000007711770000000000077117700000000000000000000000000000000000000000000000000000000000000000000
00007788770000000000000778877000000077117700000000000007711770000000000000000000000000000000000000000000000000000000000000000000
00077887700000000000000077887700000771177000000000000000771177000000000000000000000000000000000000000000000000000000000000000000
00778877000000000000000007788700007711770000000000000000077117000000000000000000000000000000000000000000000000000000000000000000
00788770000000000000000000777700007117700000000000000000007777000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000000000007117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000000000007117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000000000007117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000000000007117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000000000007117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000000000007117000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00788700000000007777777777777700007117000000000077777777777777000000000000000000000000000000000000000000000000000000000000000000
00788700000000007888888888888700007117000000000071111111111117000000000000000000000000000000000000000000000000000000000000000000
00788700000000007888888888888700007117000000000071111111111117000000000000000000000000000000000000000000000000000000000000000000
00788700000000007888777777778700007117000000000071117777777717000000000000000000000000000000000000000000000000000000000000000000
00788700000000007777700000778700007117000000000077777000007717000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000778700007117000000000000000000007717000000000000000000000000000000000000000000000000000000000000000000
00788700000000000000000000778700007117000000000000000000007717000000000000000000000000000000000000000000000000000000000000000000
00788770000000000000000000778700007117700000000000000000007717000000000000000000000000000000000000000000000000000000000000000000
00778877000000000000000007788700007711770000000000000000077117000000000000000000000000000000000000000000000000000000000000000000
00077887700000000000000077887700000771177000000000000000771177000000000000000000000000000000000000000000000000000000000000000000
00007788770000000000000778877000000077117700000000000007711770000000000000000000000000000000000000000000000000000000000000000000
00000778877000000000007788770000000007711770000000000077117700000000000000000000000000000000000000000000000000000000000000000000
00000077887777777777777887700000000000771177777777777771177000000000000000000000000000000000000000000000000000000000000000000000
00000007788888888888888877000000000000077111111111111111770000000000000000000000000000000000000000000000000000000000000000000000
00000000778888888888888770000000000000007711111111111117700000000000000000000000000000000000000000000000000000000000000000000000
00000000077777777777777700000000000000000777777777777777000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
011400081371413721137311374113741137311372113715130001300013000130001300013000130001300013000130001300010702257022570225702257022570225702257020070225702107020470210702
011400080d7140d7210d7310d7410d7410d7310d7210d715107030c70310703107030070300703007030070310703007031070310703007030070300703007030070300703007030070300703007030070300703
01140000046350460504635000001c6551c7002170500000046350000004635000001c6551c6551c6551c60500000000000000000000000000000000000000000000000000000000000000000000000000000000
01140000046050460504605000001c6051c7002170500000046050000004605000001c6051c6051c6051c60500000000000000000000000000000000000000000000000000000000000000000000000000000000
01140010000040000500004000051c60510706007061c605106051c605106051c6051c60510706007060070600706007060070600706007060070600706007060070600706007060070600706007060070600706
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000d64521605176451c6050d645176550d645176550d645176450d655176550d645176550d64517655316052d6052f60534605316052d6052f605346053d605396053b6051c6053d605396053b60534605
010200003415334153341533415334153341533415334153301030010300103001030010300103001030010300103001030010300103001030010300103001030010300103001030010300103001030010300103
01200000210752d005250050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
012000001907500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
0110000804573005030050304503015730c5030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503
0110000704573005030050301573015030c5030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503
0110000604573005030157304503015030c5030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503
0110000404573015730050304503015030c5030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503005030050300503
010c00001063400604006340060400604186040060400604006040060400604006040060400604006040060400604006040060400604006040060400604006040060400604006040060400604006040060400604
010c00000063400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004
__music__
01 00404344
00 01424344
00 00024344
02 01024344
00 40444344
00 41444344
00 42444344
00 43444344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

