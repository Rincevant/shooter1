Player = {
    x = 0,
    y = 500,
    image = love.graphics.newImage("images/player2.png"),
    bullets = {},
    countdown = 20,

    new = function()
        p = {}
        for i, v in pairs(Player) do
            p[i] = v 
        end
        return p
    end,

    fire = function(self)
        if self.countdown < 0 then
            self.countdown = 20
            bullet = {}
            bullet.x = self.x - 2.5
            bullet.y = self.y - self.image:getHeight() / 2
            table.insert( self.bullets, bullet)
        end
    end 
}