function love.load()
    
    -- Setup Window
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
    
    -- Player
    player = {}
    player.image = love.graphics.newImage("images/player2.png")
    player.x = 0
    player.y = 500
    player.bullets = {}
    player.countdown = 20

    -- Bullet
    player.fire = function()
        if player.countdown < 0 then
            player.countdown = 20
            bullet = {}
            bullet.x = player.x - 2.5
            bullet.y = player.y - player.image:getHeight() / 2
            table.insert( player.bullets, bullet)
        end
    end

    -- Enemy
    enemy = {}
    enemy.x = width / 2
    enemy.y = 300
    enemy.image = player.image

    -- Collision
    local bool = false
    x ,y = 0,0
    
end

function love.update(dt)

    -- Direction
    if love.keyboard.isDown("right") then
        player.x = player.x + 5
    elseif love.keyboard.isDown("left") then
        player.x = player.x - 5
    end
    
    if love.keyboard.isDown("up") then
        player.y = player.y - 5
    elseif love.keyboard.isDown("down") then
        player.y = player.y + 5
    end

    
    -- Shoot
    player.countdown = player.countdown - 1
    if love.keyboard.isDown("space") then
        player.fire()
    end

    -- Update Player Bullets
    for i,b in ipairs(player.bullets) do
        if (b.y < -10) then
            table.remove( player.bullets, i)
        end
            bool = CheckCollision(b)
            if bool == true then
               table.remove( player.bullets, i)
            end
            b.y = b.y - 10
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
    
    -- Draw Player
    love.graphics.draw(player.image, player.x, player.y, 0, 1, 1, player.image:getWidth()/2, player.image:getHeight()/2)
    
    -- Draw Player Bullet
    for _,b in pairs(player.bullets) do
        love.graphics.rectangle("fill", b.x, b.y, 5, 5)
    end

    -- Draw enemy
    love.graphics.draw(enemy.image, enemy.x, enemy.y, math.rad(180), 1, 1, enemy.image:getWidth()/2, enemy.image:getHeight()/2)
    information()
end

function information()
    love.graphics.print(tostring(player.x .. " " .. player.y),0 , 0)
    love.graphics.print(tostring(table.maxn(player.bullets)),0 , 20)
    love.graphics.print(tostring(bool),0, 40)
    love.graphics.print(tostring(x .. " " .. y),0, 60)
end

function CheckCollision(b)
        return b.x <  enemy.x + enemy.image:getWidth() / 2 and 
           enemy.x - enemy.image:getWidth() / 2 < b.x + 5 and
           b.y < enemy.y + enemy.image:getHeight() / 2 and
           enemy.y - enemy.image:getHeight() / 2 < b.y + 5
end
