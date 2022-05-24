-- @author Malody Hoe / GitHub: undefinist / Twitter: undefinist
function hsvToRgb(h, s, v)
  local r, g, b

  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

function Initialize()
    NumOfItems = SKIN:ParseFormula(SKIN:GetVariable("NumOfItems"))
    MinBallSize = SKIN:ParseFormula(SKIN:GetVariable("MinBallSize"))
    MaxBallSize = SKIN:ParseFormula(SKIN:GetVariable("MaxBallSize"))
    MaxColliderSize = SKIN:ParseFormula(SKIN:GetVariable("MaxColliderSize"))
    HueStart = SKIN:ParseFormula(SKIN:GetVariable("HueStart"))
    HueEnd = SKIN:ParseFormula(SKIN:GetVariable("HueEnd"))
    SatZero = SKIN:ParseFormula(SKIN:GetVariable("SatZero"))
    SatMin = SKIN:ParseFormula(SKIN:GetVariable("SatMin"))
    SatMax = SKIN:ParseFormula(SKIN:GetVariable("SatMax"))
    ValZero = SKIN:ParseFormula(SKIN:GetVariable("ValZero"))
    ValMin = SKIN:ParseFormula(SKIN:GetVariable("ValMin"))
    ValMax = SKIN:ParseFormula(SKIN:GetVariable("ValMax"))
    NoParticles = SKIN:ParseFormula(SKIN:GetVariable("NoParticles")) == 1

	measures = {}
	balls = {}

    particles = {}
	for i = 0,NumOfItems-1 do
        table.insert(measures, SKIN:GetMeasure("mBand" .. i))
        local m = SKIN:GetMeter("Ball" .. i)
        local x = m:GetX()
        local y = m:GetY()
        table.insert(balls, {meter = m, ox = x, oy = y, x = x, y = y})

        if not NoParticles then
            local p = SKIN:GetMeter("Particle" .. i)
            local px = p:GetX()
            local py = p:GetY()
    		table.insert(particles, {meter = p, ox = px, oy = py, x = px, y = py, vx = 0, vy = 0})
        end
	end
    if not NoParticles then
        ParticleFloor = particles[1]["y"]
    end
end

function Update()
	process()
end

function process()
	collide(math.ceil(NumOfItems/2), -1)
    collide(math.ceil(NumOfItems/2), 1)

    -- local particle = SKIN:GetMeter("Particle")

    for i = 1,#measures do
        local band = measures[i]:GetValue()
        local s = SatMin + (SatMax - SatMin) * band
        local v = ValMin + (ValMax - ValMin) * band
		--v = (i / #measures);
		--s = 0;
        if band == 0 then
            s = SatZero
            v = ValZero
        end
        local r,g,b = hsvToRgb((HueStart + (HueEnd - HueStart) * (i / #measures))/360, s, v)
        SKIN:Bang("!SetOption", "Ball" .. (i-1), "ColorMod", "Fill Color " .. r .. "," .. g .. "," .. b)

        if not NoParticles then
            local x = balls[i]["x"]
            local y = balls[i]["y"]
            local r = measures[i]:GetValue() * (MaxBallSize - MinBallSize) + MinBallSize

            for j = 1,#measures do
                local particle = particles[j]
                local dx = particle["x"] - x
                local dy = particle["y"] - y
                local diff_sq = dx^2 + dy^2

                if diff_sq < r^2 and diff_sq > particle["vx"]^2 + particle["vy"]^2 then
                    particle["vx"] = dx * 0.2
                    if particle["vy"] > 0 then
                        particle["vy"] = 0
                    else
                        particle["vy"] = -math.abs(dy) * 0.75
                    end
                end
            end
        end
    end

    if NoParticles then return end

    for i = 1,#measures do
        local particle = particles[i]
        local px = particle["x"]
        local py = particle["y"]
        local vx = particle["vx"]
        local vy = particle["vy"]
        px = px + vx * 0.5
        py = py + vy * 0.4
        vy = vy + 0.4
        if py >= ParticleFloor then
            py = ParticleFloor
            px = particle["ox"]
            vy = 0
            vx = 0
        end
        particle["meter"]:SetX(px)
        particle["meter"]:SetY(py)
        particle["x"] = px
        particle["y"] = py
        particle["vx"] = vx
        particle["vy"] = vy
        local v = 255 - py / ParticleFloor * 255
        SKIN:Bang("!SetOption", "Particle" .. (i-1), "ColorMod", "Fill Color #ParticleColor#," .. v)
    end

end

function collide(first, step)
    local last = 1
    if step == 1 then last = NumOfItems end
    for i = first+step,last,step do
        local x = balls[i]["x"]
        local y = balls[i]["y"]
        local r = measures[i]:GetValue() * (MaxColliderSize - MinBallSize) + MinBallSize

        for j = i-step,first,-step do
            local xj = balls[j]["x"]
            local yj = balls[j]["y"]
            local rj = measures[j]:GetValue() * (MaxColliderSize - MinBallSize) + MinBallSize

            local dx = x - xj
            local dy = y - yj
            local diff_sq = dx^2 + dy^2
            if diff_sq < (r + rj)^2 then
                x = xj + math.abs(dx) * step / math.sqrt(diff_sq) * (r + rj)
                y = yj + dy / math.sqrt(diff_sq) * (r + rj)
            end
        end

        x = x - (x - balls[i]["ox"]) * 0.1
        y = y - (y - balls[i]["oy"]) * 0.1
        if math.abs(x - balls[i]["ox"]) < 0.1 then x = balls[i]["ox"] end
        if math.abs(y - balls[i]["oy"]) < 0.1 then y = balls[i]["oy"] end

        balls[i]["x"] = x
        balls[i]["y"] = y
        balls[i]["meter"]:SetX(x)
        balls[i]["meter"]:SetY(y)
    end
end
