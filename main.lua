require("enemy")
require("player")

function love.load()
    
    -- Setup Window
    --love.window.setMode(1920,1080, {fullscreen=true})
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    -- Load Background
    background = love.graphics.newImage("images/nebula_blue.png")
    stars = {}
    stars.stars1 = love.graphics.newImage("images/stars_small.png")
    stars.stars2 = love.graphics.newImage("images/stars_small2.png")
    table.insert( stars, stars.stars1)    
    table.insert( stars, stars.stars1)
    stars_1 = 0
    stars_2 = -600
    stars_3 = -600
    
    -- Load Player
    p1 = Player.new()
    
    -- Load Level
    level1 = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
    }

    
    Ew = (width - ((#level1[1]+1) * 15)) / #level1[1] 
    Lw = (10 * Ew/2) + (9 * 15)
    
    -- Load Enemies
    enemies = {}
    for i=1, #level1 do
        enemies[i] = {}
        for j=1, 10 do
            e = Enemy.new()
            enemies[i][j] = e
        end
    end

    for j = 1, #level1 do
        for i = 0, 9 do
            --Enemy[i+1]:spawn( (Ew/2*i) + (15*(i+1)) + ((width-Lw)/2), j* -40)
            enemies[j][i+1]:spawn((Ew/2*i) + (15*(i+1)) + ((width-Lw)/2), j* -40)
        end
    end

    -- Collision
    local bool = false
    x ,y = 0,0
    
end

function love.update(dt)

    -- Direction
    if love.keyboard.isDown("right") then
        p1.x = p1.x + 5
    elseif love.keyboard.isDown("left") then
        p1.x = p1.x - 5
    end
    
    if love.keyboard.isDown("up") then
        p1.y = p1.y - 5
    elseif love.keyboard.isDown("down") then
        p1.y = p1.y + 5
    end

    
    -- Shoot
    p1.countdown = p1.countdown - 1
    if love.keyboard.isDown("space") then
        p1:fire()
    end

    -- Update Player Bullets
    for i,b in ipairs(p1.bullets) do
        if (b.y < -10) then
            table.remove( p1.bullets, i)
        end
            --bool = CheckCollision(b)
            if bool == true then
               table.remove( p1.bullets, i)
            end
            b.y = b.y - 10
    end

    -- Update Enemies
    for i,e in ipairs(Enemy) do
        e.countdown = e.countdown - 1
        e:fire()
        for j,b in ipairs(e.bullets) do
            b.y = b.y + 10
        end
        e.y = e.y + 1 * e.speed
    end

    -- Update Background
    if (stars_1 > 600) then
        stars_1 = -600
    elseif (stars_2 > 600) then
        stars_2 = -600
    elseif (stars_3 > 600) then
        stars_3 = -1500
    end
    
    stars_1 = stars_1 + 0.5
    stars_2 = stars_2 + 0.5
    stars_3 = stars_3 + 1   
end

function love.draw()
    
    -- Draw Background
    love.graphics.draw(background, 0, 0, 0, 0.4, 0.4)
    love.graphics.draw(stars[1], 0, stars_1, 0)
    love.graphics.draw(stars[2], 0, stars_2, 0)
    love.graphics.draw(stars.stars2, 0, stars_3, 0 , 0.4, 0.4)
    
    -- Draw p1
    love.graphics.draw(p1.image, p1.x, p1.y, 0, 1, 1, p1.image:getWidth()/2, p1.image:getHeight()/2)
    
    -- Draw p1 Bullet
    for _,b in pairs(p1.bullets) do
        love.graphics.rectangle("fill", b.x, b.y, 5, 5)
    end

    -- Draw enemy
    for i,e in ipairs(Enemy) do
        love.graphics.rectangle("fill", e.x, e.y, Ew/4, Ew/4)
    end

    -- Draw Enemy Bullet
    for i,e in ipairs(Enemy) do
        for j,b in ipairs(e.bullets) do
            love.graphics.rectangle("fill", b.x, b.y, 5, 5)
        end
    end
    information()
end

function information()
    --love.graphics.print(tostring(p1.x .. " " .. p1.y),0 , 0)
    --love.graphics.print(tostring(table.maxn(p1.bullets)),0 , 20)
    --love.graphics.print(tostring(bool),0, 40)
    --love.graphics.print(tostring(x .. " " .. y),0, 60)
    --love.graphics.print(#level1 .. " ".. Ew .. " " .. Lw, 0, 100)
end

function CheckCollision(b)
        return b.x <  enemy.x + 30 / 2 and 
           enemy.x - 30 / 2 < b.x + 5 and
           b.y < enemy.y + 30 / 2 and
           enemy.y - 30 / 2 < b.y + 5
end
