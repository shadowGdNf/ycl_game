local log = require("klua.log"):new("render_utils")
local I = require("klove.image_db")
local G = love.graphics
local EXO = require("exoskeleton")
local RU = {
	BATCHES_COUNT = 30,
	BATCH_SIZE = 50,
	batches = {},
	bi = 1
}

function RU.init()
	RU.add_batches(RU.BATCHES_COUNT)

	RU.bi = 1
	RU.last_texture = nil
	RU.last_hb_quad = nil
	RU.hb_quads = {}

	for i, q in ipairs(HEALTH_BAR_CORNER_DOT_QUADS) do
		RU.hb_quads[i] = G.newQuad(unpack(q))
	end
end

function RU.destroy()
	RU.batches = {}
	RU.last_texture = nil
	RU.last_hb_quad = nil
	RU.hb_quads = nil
end

function RU.new_frame()
	RU.bi = 1
end

function RU.add_batches(count)
	if #RU.batches > 1000 and not RU.too_many_batches then
		log.error("1000 sprite batches per frame exceeded! Way too many batches!")

		RU.too_many_batches = true
	end

	local temp_canvas = G.newCanvas(2, 2)

	for i = 1, count do
		table.insert(RU.batches, G.newSpriteBatch(temp_canvas, RU.BATCH_SIZE, "stream"))
	end
end

function RU.frame_draw_params(f, hb_quad)
	local ss = f.ss
	local x = f.pos.x + f.offset.x
	local y = REF_H - (f.pos.y + f.offset.y)
	local r = -f.r
	local ref_scale = ss.ref_scale or 1
	local sy = (f.flip_y and -1 or 1) * ref_scale
	local sx = (f.flip_x and -1 or 1) * ref_scale

	if f.scale then
		sy = sy * f.scale.y
		sx = sx * f.scale.x
	end

	local ox = f.anchor.x * ss.size[1] - ss.trim[1]
	local oy = (1 - f.anchor.y) * ss.size[2] - ss.trim[2]
	local quad = ss.quad

	if not ss.atlas then
		quad = hb_quad or RU.hb_quads[1]
	end

	return quad, x, y, r, sx, sy, ox, oy
end

function RU.draw_frames_range(frames, start_idx, max_z)
	local current_atlas, lr, lg, lb, la = nil
	local cr = 255
	local cg = 255
	local cb = 255
	local ca = 255
	local batch_count = 0
	local batches_count = 0
	local BATCH_SIZE = RU.BATCH_SIZE
	local last_idx = start_idx
	local frame_draw_params = RU.frame_draw_params
	local batches = RU.batches
	local bi = RU.bi
	local bi_count = #RU.batches
	local batch = batches[bi]
	local last_texture = RU.last_texture
	local last_hb_quad = RU.last_hb_quad
	local q1 = RU.hb_quads[1]
	local q2 = RU.hb_quads[2]
	local q3 = RU.hb_quads[3]
	local q4 = RU.hb_quads[4]
	local s1024 = 1024
	local s2048 = 2048
	local s4096 = 4096
	local current_shader = nil

	batch:clear()

	if last_texture then
		batch:setTexture(last_texture)
	end

	G.setColor(255, 255, 255, 255)

	for i = start_idx, #frames do
		local f = frames[i]

		if max_z <= f.z then
			break
		end

		last_idx = i
		local ss = f.ss

		if f.hidden then
			-- Nothing
		elseif f.exo then
			for part_idx, part in ipairs(f.exo_frame) do
				local part_type, part_name_idx, alpha, x, y, sx, sy, r, kx, ky = unpack(part)

				if part_type == 8 then
					local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)
					sy = sy * (f.flip_y and -1 or 1)
					sx = sx * (f.flip_x and -1 or 1)
					local f_sx = f.flip_x and -1 or 1
					local f_sy = f.flip_y and -1 or 1

					if f.scale then
						sy = sy * f.scale.y
						sx = sx * f.scale.x
						f_sx = f_sx * f.scale.x
						f_sy = f_sy * f.scale.y
					end

					local p_x_s = x * f_sx
					local p_y_s = y * f_sy
					r = -f.r * flipf + r

					if f.r ~= 0 then
						local cr = math.cos(-f.r)
						local sr = math.sin(-f.r)
						local p_x = p_x_s * cr - p_y_s * sr
						local p_y = p_x_s * sr + p_y_s * cr
						x = p_x + f.pos.x + f.offset.x
						y = -p_y + f.pos.y + f.offset.y
					else
						x = p_x_s + f.pos.x + f.offset.x
						y = -p_y_s + f.pos.y + f.offset.y
					end

					if not f.last_attach_point_xform then
						f.last_attach_point_xform = {}
					end

					if not f.last_attach_point_xform[part_name_idx] then
						f.last_attach_point_xform[part_name_idx] = {}
					end

					local l = f.last_attach_point_xform[part_name_idx]
					l.y = y
					l.x = x
					l.r = r * flipf
					l.sy = sy
					l.sx = sx
				else
					local part_name, pox, poy = unpack(f.exo.parts[part_name_idx])
					local ss = I:s(part_name)

					if not part.hidden then
						if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
							if batch_count > 0 then
								G.draw(batch)

								bi = bi + 1

								if bi_count < bi then
									RU.add_batches(10)

									bi_count = #RU.batches
								end

								batch = batches[bi]

								if last_texture then
									batch:setTexture(last_texture)
								end
							end

							batch:clear()

							la = nil
							lb = nil
							lg = nil
							lr = nil

							if ss.atlas then
								local im, w, h = I:i(ss.atlas)
								current_atlas = ss.atlas
								last_texture = im

								if w then
									local d = w

									if d < h then
										d = h
									end

									if s4096 < d then
										last_hb_quad = q4
									elseif s2048 < d then
										last_hb_quad = q3
									elseif s1024 < d then
										last_hb_quad = q2
									else
										last_hb_quad = q1
									end
								end

								batch:setTexture(im)
							end

							batch_count = 0
							batches_count = batches_count + 1

							if f.shader ~= current_shader then
								G.setShader(f.shader)

								if f.shader_args then
									for k, v in pairs(f.shader_args) do
										f.shader:send(k, v)
									end
								end

								current_shader = f.shader
							end
						end

						if f.color then
							cb = f.color[3]
							cg = f.color[2]
							cr = f.color[1]
						else
							cb = 255
							cg = 255
							cr = 255
						end

						ca = f.alpha * (alpha or 1)

						if ca ~= la or cr ~= lr or cg ~= lg or cb ~= lb then
							batch:setColor(cr, cg, cb, ca)

							la = ca
							lb = cb
							lg = cg
							lr = cr
						end

						local quad = ss.quad
						local ref_scale = ss.ref_scale or 1
						local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)
						sy = sy * (f.flip_y and -1 or 1) * ref_scale
						sx = sx * (f.flip_x and -1 or 1) * ref_scale
						local f_sx = f.flip_x and -1 or 1
						local f_sy = f.flip_y and -1 or 1

						if f.scale then
							sy = sy * f.scale.y
							sx = sx * f.scale.x
							f_sx = f_sx * f.scale.x
							f_sy = f_sy * f.scale.y
						end

						local ox = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
						local oy = 0.5 * ss.size[2] - ss.trim[2] - poy / ref_scale
						local p_x_s = x * f_sx
						local p_y_s = y * f_sy
						r = -f.r * flipf + r

						if f.r ~= 0 then
							local cr = math.cos(-f.r)
							local sr = math.sin(-f.r)
							local p_x = p_x_s * cr - p_y_s * sr
							local p_y = p_x_s * sr + p_y_s * cr
							x = p_x + f.pos.x + f.offset.x
							y = REF_H - (-p_y + f.pos.y + f.offset.y)
						else
							x = p_x_s + f.pos.x + f.offset.x
							y = REF_H - (-p_y_s + f.pos.y + f.offset.y)
						end

						batch:add(quad, x, y, r * flipf, sx, sy, ox, oy, kx, ky)

						batch_count = batch_count + 1
					end
				end
			end
		elseif ss then
			if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
				if batch_count > 0 then
					G.draw(batch)

					bi = bi + 1

					if bi_count < bi then
						RU.add_batches(10)

						bi_count = #RU.batches
					end

					batch = batches[bi]

					if last_texture then
						batch:setTexture(last_texture)
					end
				end

				batch:clear()

				la = nil
				lb = nil
				lg = nil
				lr = nil

				if ss.atlas then
					local im, w, h = I:i(ss.atlas)
					current_atlas = ss.atlas
					last_texture = im

					if w then
						local d = w

						if d < h then
							d = h
						end

						if s4096 < d then
							last_hb_quad = q4
						elseif s2048 < d then
							last_hb_quad = q3
						elseif s1024 < d then
							last_hb_quad = q2
						else
							last_hb_quad = q1
						end
					end

					batch:setTexture(im)
				end

				batch_count = 0
				batches_count = batches_count + 1

				if f.shader ~= current_shader then
					G.setShader(f.shader)

					if f.shader_args then
						for k, v in pairs(f.shader_args) do
							f.shader:send(k, v)
						end
					end

					current_shader = f.shader
				end
			end

			if f.color then
				cb = f.color[3]
				cg = f.color[2]
				cr = f.color[1]
			else
				cb = 255
				cg = 255
				cr = 255
			end

			ca = f.alpha

			if ca ~= la or cr ~= lr or cg ~= lg or cb ~= lb then
				batch:setColor(cr, cg, cb, ca)

				la = ca
				lb = cb
				lg = cg
				lr = cr
			end

			batch:add(frame_draw_params(f, last_hb_quad))

			batch_count = batch_count + 1
		end
	end

	if batch_count > 0 then
		G.draw(batch)

		bi = bi + 1

		if bi_count < bi then
			RU.add_batches(10)

			bi_count = #RU.batches
		end

		batch = batches[bi]
		batches_count = batches_count + 1
	end

	G.setColor(255, 255, 255, 255)

	if current_shader then
		G.setShader()
	end

	RU.bi = bi
	RU.last_texture = last_texture
	RU.last_hb_quad = last_hb_quad

	return last_idx
end

return RU
