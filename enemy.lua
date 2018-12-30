Enemy = {
    x = 0,
    y = 0,
    countdown = 20,
    speed = 0.5,
    
    new = function()
        e = {}
        for i, v in pairs(Enemy) do
            e[i] = v 
        end
        e.bullets = {}
        table.insert(Enemy, e)
        return e
    end,

    spawn = function(self, newX, newY) 
        self.x = newX
        self.y = newY
    end,

    fire = function(self)
        if self.countdown < 0 then
            self.countdown = 100
            bullet = {}
            bullet.x = self.x - 2.5
            bullet.y = self.y
            table.insert(self.bullets, bullet)
        end
    end
}