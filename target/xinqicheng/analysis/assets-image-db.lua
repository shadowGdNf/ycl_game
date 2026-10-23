local log = require("klua.log"):new("image_db")
local G = love.graphics
local FS = love.filesystem

require("klua.table")
require("klua.dump")

local km = require("klua.macros")
local image_db = {
	db_images = {},
	db_atlas = {},
	atlas_uses = {},
	load_queue = {},
	load_queue_current = nil,
	progress = 0,
	groups_total = 0,
	groups_done = 0,
	missing_images = {},
	missing_sprites = {},
	threads = {},
	image_name_queue = {},
	queue_load_total_images = 0,
	queue_load_done_images = 0,
	last_preloaded_group_names = {},
	use_canvas = true,
	release_compressed_data = false
}
IMAGE_DB_DEFAULT_ATLAS_GROUP = "image_db_default"
local DEFAULT_ATLAS_1X1_SPRITES = {
	_1x1_black = {
		0,
		0,
		0,
		255
	},
	_1x1_white = {
		255,
		255,
		255,
		255
	},
	_1x1_transparent = {
		0,
		0,
		0,
		0
	}
}
local _MAX_THREADS = 8
local _LOAD_IMAGE_THREAD_CODE = [[
local cin,cout,th_i = ...
require 'love.filesystem'
require 'love.image'
require 'love.timer'
local file_count = 0
while true do
    -- get params
    local fn = cin:demand()
    if fn == 'QUIT' then goto quit end
    local path = cin:demand()
    local f = path .. '/' .. fn

    --print('TH  ' ..th_i.. ' ARGS ' .. fn .. ' ' .. path .. '\n')
    
    if not love.filesystem.isFile(f) then
        cout:push({'ERROR','Not a file',f})
    else
        local data
        if string.match(fn, '.pkm.lz4$') or string.match(fn, '.ktx.lz4$') or string.match(fn, '.ktx$') or string.match(fn, '.pkm$') or string.match(fn, '.astc$') or string.match(fn, '.dds$') then
            data = love.image.newCompressedData(f)
        else
            data = love.image.newImageData(f)
        end
        --print('TH  ' ..th_i.. ' newXData time: ' .. (love.timer.getTime()-t_start) .. '\n')
        if not data then
            cout:push({'ERROR','Image could not be loaded',f})
        else
            file_count = file_count + 1
            local w,h = data:getDimensions()
            local key = string.gsub(fn, '.png$', '')
            key = string.gsub(key, '.lz4$', '')
            key = string.gsub(key, '.jpg$', '')
            key = string.gsub(key, '.pkm$', '')
            key = string.gsub(key, '.ktx$', '')
            key = string.gsub(key, '.astc$', '')
            key = string.gsub(key, '.dds$', '')
            cout:push({'OK',key,data,w,h})
        end
    end
end
::quit::
cout:supply({'DONE'})
--print('TH  ' ..th_i.. ' QUIT - FILES LOADED ' .. file_count .. '\n')
]]

function image_db:get_short_stats()
	local count_frames = 0
	local o = ""
	local list = {}
	o = o .. "Atlas frames count: "

	for k, v in pairs(self.db_atlas) do
		count_frames = count_frames + 1
	end

	o = o .. count_frames .. "\n"
	o = o .. "Loaded images: "

	for k, v in pairs(self.db_images) do
		if v[1] then
			table.insert(list, k)
		end
	end

	table.sort(list)

	o = o .. table.concat(list, ", ")
	o = o .. "\nTexture memory (MB): " .. love.graphics.getStats().texturememory / 1048576

	return o
end

function image_db:get_stats(detailed)
	local count_images = 0
	local count_images_MB = 0
	local count_frames = 0
	local count_images_deferred = 0
	local o = ""
	o = o .. "Loaded images ------------------\n"
	local list = {}

	for k, v in pairs(self.db_images) do
		if v[1] then
			count_images = count_images + 1
			local mb = v[2] * v[3] * 4 / 1048576
			count_images_MB = count_images_MB + mb
			local line = k .. "    " .. v[2]

			if detailed then
				line = line .. "x" .. v[3] .. " (" .. mb .. ")"
			end

			line = line .. "\n"

			table.insert(list, line)
		else
			count_images_deferred = count_images_deferred + 1
		end
	end

	table.sort(list)

	for _, row in pairs(list) do
		o = o .. row
	end

	o = o .. "\n"
	o = o .. "Atlas usage---------------------\n"

	for k, v in pairs(self.atlas_uses) do
		o = o .. k .. ":" .. v .. "\n"
	end

	for k, v in pairs(self.db_atlas) do
		count_frames = count_frames + 1
	end

	o = o .. "\n"
	o = o .. "Counts---------------------\n"
	o = o .. "Total images: " .. count_images .. " (" .. count_images_MB .. " MB)\n"
	o = o .. "Total deferred images: " .. count_images_deferred .. "\n"
	o = o .. "Total frames: " .. count_frames .. "\n"
	o = o .. "\n"
	o = o .. "love.graphics.getStats()---\n"
	o = o .. getdump(love.graphics.getStats())

	return o
end

function image_db:queue_load_done()

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-4, warpins: 1 ---
	if #self.load_queue == 0 and #self.threads == 0 then

		-- Decompilation error in this vicinity:
		--- BLOCK #2 9-14, warpins: 1 ---
		self.progress = 1
		self.groups_total = 0

		return true
		--- END OF BLOCK #2 ---



	end

	--- END OF BLOCK #0 ---

	FLOW; TARGET BLOCK #3



	-- Decompilation error in this vicinity:
	--- BLOCK #1 5-8, warpins: 1 ---
	--- END OF BLOCK #1 ---

	if #self.threads == 0 then
	JUMP TO BLOCK #2
	else
	JUMP TO BLOCK #3
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #2 9-14, warpins: 1 ---
	self.progress = 1
	self.groups_total = 0

	return true

	--- END OF BLOCK #2 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #3 15-17, warpins: 3 ---
	if not self.queue_load_start_time then

		-- Decompilation error in this vicinity:
		--- BLOCK #4 18-23, warpins: 1 ---
		log.start_time("textures")

		self.queue_load_start_time = true
		--- END OF BLOCK #4 ---



	end

	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #5



	-- Decompilation error in this vicinity:
	--- BLOCK #4 18-23, warpins: 1 ---
	log.start_time("textures")

	self.queue_load_start_time = true
	--- END OF BLOCK #4 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #5 24-28, warpins: 3 ---
	--- END OF BLOCK #5 ---

	FLOW; TARGET BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #6 29-44, warpins: 2 ---
	local item = table.remove(self.load_queue, 1)
	local ref_scale, path, name = unpack(item)
	local image_names = self:preload_atlas(ref_scale, path, name)

	--- END OF BLOCK #6 ---

	FLOW; TARGET BLOCK #9



	-- Decompilation error in this vicinity:
	--- BLOCK #7 45-48, warpins: 1 ---
	--- END OF BLOCK #7 ---

	FLOW; TARGET BLOCK #8



	-- Decompilation error in this vicinity:
	--- BLOCK #8 49-58, warpins: 1 ---
	table.insert(self.image_name_queue, {
		n,
		path
	})

	self.queue_load_total_images = self.queue_load_total_images + 1
	--- END OF BLOCK #8 ---

	FLOW; TARGET BLOCK #9



	-- Decompilation error in this vicinity:
	--- BLOCK #9 59-60, warpins: 2 ---
	--- END OF BLOCK #9 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #10 61-61, warpins: 2 ---
	--- END OF BLOCK #10 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #5



	-- Decompilation error in this vicinity:
	--- BLOCK #11 62-65, warpins: 1 ---
	--- END OF BLOCK #11 ---

	if #self.threads == 0 then
	JUMP TO BLOCK #12
	else
	JUMP TO BLOCK #17
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #12 66-74, warpins: 1 ---
	--- END OF BLOCK #12 ---

	FLOW; TARGET BLOCK #13



	-- Decompilation error in this vicinity:
	--- BLOCK #13 75-97, warpins: 2 ---
	local th = love.thread.newThread(_LOAD_IMAGE_THREAD_CODE)
	local cin = love.thread.newChannel()
	local cout = love.thread.newChannel()

	th:start(cin, cout, i)
	--- END OF BLOCK #13 ---

	slot8 = if love.nx then
	JUMP TO BLOCK #14
	else
	JUMP TO BLOCK #15
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #14 98-111, warpins: 1 ---
	th:setAffinity({
		false,
		true,
		true
	})
	log.paranoid(" ++++ IMAGE_DB THREAD %s AFFINITY %s", th, getdump(th:getAffinity()))
	--- END OF BLOCK #14 ---

	FLOW; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #15 112-120, warpins: 2 ---
	table.insert(self.threads, {
		th,
		cin,
		cout
	})

	--- END OF BLOCK #15 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #16 121-122, warpins: 1 ---
	self.last_thread_used = 1
	--- END OF BLOCK #16 ---

	FLOW; TARGET BLOCK #17



	-- Decompilation error in this vicinity:
	--- BLOCK #17 123-127, warpins: 2 ---
	--- END OF BLOCK #17 ---

	if #self.image_name_queue > 0 then
	JUMP TO BLOCK #18
	else
	JUMP TO BLOCK #20
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #18 128-132, warpins: 1 ---
	--- END OF BLOCK #18 ---

	FLOW; TARGET BLOCK #19



	-- Decompilation error in this vicinity:
	--- BLOCK #19 133-160, warpins: 2 ---
	local image_name, path = unpack(table.remove(self.image_name_queue, 1))
	local cin = self.threads[self.last_thread_used][2]

	cin:push(image_name)
	cin:push(path)

	self.last_thread_used = km.zmod(self.last_thread_used + 1, #self.threads)

	--- END OF BLOCK #19 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #20 161-165, warpins: 2 ---
	--- END OF BLOCK #20 ---

	FLOW; TARGET BLOCK #21



	-- Decompilation error in this vicinity:
	--- BLOCK #21 166-173, warpins: 2 ---
	self.threads[i][2]:push("QUIT")
	--- END OF BLOCK #21 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #22 174-179, warpins: 1 ---
	--- END OF BLOCK #22 ---

	slot1 = if not love.graphics.isActive()

	 then
	JUMP TO BLOCK #23
	else
	JUMP TO BLOCK #24
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #23 180-181, warpins: 1 ---
	return false

	--- END OF BLOCK #23 ---

	FLOW; TARGET BLOCK #24



	-- Decompilation error in this vicinity:
	--- BLOCK #24 182-186, warpins: 2 ---
	--- END OF BLOCK #24 ---

	FLOW; TARGET BLOCK #25



	-- Decompilation error in this vicinity:
	--- BLOCK #25 187-195, warpins: 2 ---
	local th, cin, cout = unpack(self.threads[i])

	--- END OF BLOCK #25 ---

	slot8 = if th:isRunning()

	 then
	JUMP TO BLOCK #26
	else
	JUMP TO BLOCK #41
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #26 196-200, warpins: 1 ---
	local result = cout:pop()
	--- END OF BLOCK #26 ---

	slot8 = if result then
	JUMP TO BLOCK #27
	else
	JUMP TO BLOCK #42
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #27 201-205, warpins: 1 ---
	local r1, r2, r3, r4, r5 = unpack(result)

	--- END OF BLOCK #27 ---

	if r1 == "DONE" then
	JUMP TO BLOCK #28
	else
	JUMP TO BLOCK #29
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #28 206-211, warpins: 1 ---
	table.remove(self.threads, i)
	--- END OF BLOCK #28 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #42



	-- Decompilation error in this vicinity:
	--- BLOCK #29 212-213, warpins: 1 ---
	--- END OF BLOCK #29 ---

	if r1 == "ERROR" then
	JUMP TO BLOCK #30
	else
	JUMP TO BLOCK #31
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #30 214-220, warpins: 1 ---
	log.error("Failed to load image file: %s. Error: %s", r3, r2)

	--- END OF BLOCK #30 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #42



	-- Decompilation error in this vicinity:
	--- BLOCK #31 221-222, warpins: 1 ---
	--- END OF BLOCK #31 ---

	if r1 == "OK" then
	JUMP TO BLOCK #32
	else
	JUMP TO BLOCK #42
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #32 223-232, warpins: 1 ---
	local key = r2
	local data = r3
	local w = r4
	local h = r5
	local im = G.newImage(data)

	--- END OF BLOCK #32 ---

	slot18 = if not im then
	JUMP TO BLOCK #33
	else
	JUMP TO BLOCK #34
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #33 233-238, warpins: 1 ---
	log.error("Image could not be created: %s", key)
	--- END OF BLOCK #33 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #42



	-- Decompilation error in this vicinity:
	--- BLOCK #34 239-241, warpins: 1 ---
	--- END OF BLOCK #34 ---

	slot19 = if self.use_canvas then
	JUMP TO BLOCK #35
	else
	JUMP TO BLOCK #37
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #35 242-246, warpins: 1 ---
	--- END OF BLOCK #35 ---

	slot19 = if not im:isCompressed()
	 then
	JUMP TO BLOCK #36
	else
	JUMP TO BLOCK #37
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #36 247-287, warpins: 1 ---
	log.paranoid(" +++ creating canvas %s", im)

	local c = G.newCanvas(w, h)

	G.setCanvas(c)
	G.setBlendMode("replace", "premultiplied")
	G.draw(im)
	G.setBlendMode("alpha", "alphamultiply")
	G.setCanvas()

	self.db_images[key] = {
		c,
		w,
		h
	}
	im = nil

	collectgarbage()
	--- END OF BLOCK #36 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #40



	-- Decompilation error in this vicinity:
	--- BLOCK #37 288-303, warpins: 2 ---
	log.paranoid(" +++ keeping image %s", im)

	self.db_images[key] = {
		im,
		w,
		h
	}

	--- END OF BLOCK #37 ---

	slot19 = if im:isCompressed()
	 then
	JUMP TO BLOCK #38
	else
	JUMP TO BLOCK #40
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #38 304-306, warpins: 1 ---
	--- END OF BLOCK #38 ---

	slot19 = if self.release_compressed_data then
	JUMP TO BLOCK #39
	else
	JUMP TO BLOCK #40
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #39 307-309, warpins: 1 ---
	im:kReleaseCompressedData()

	--- END OF BLOCK #39 ---

	FLOW; TARGET BLOCK #40



	-- Decompilation error in this vicinity:
	--- BLOCK #40 310-313, warpins: 4 ---
	self.queue_load_done_images = self.queue_load_done_images + 1

	--- END OF BLOCK #40 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #42



	-- Decompilation error in this vicinity:
	--- BLOCK #41 314-326, warpins: 1 ---
	log.error("Thread %s error:%s", i, th:getError())
	table.remove(self.threads, i)

	--- END OF BLOCK #41 ---

	FLOW; TARGET BLOCK #42



	-- Decompilation error in this vicinity:
	--- BLOCK #42 327-327, warpins: 7 ---
	--- END OF BLOCK #42 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #43 328-332, warpins: 1 ---
	--- END OF BLOCK #43 ---

	if #self.threads > 0 then
	JUMP TO BLOCK #44
	else
	JUMP TO BLOCK #45
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #44 333-338, warpins: 1 ---
	self.progress = self.queue_load_done_images / self.queue_load_total_images

	return false

	--- END OF BLOCK #44 ---

	FLOW; TARGET BLOCK #45



	-- Decompilation error in this vicinity:
	--- BLOCK #45 339-343, warpins: 2 ---
	--- END OF BLOCK #45 ---

	if #self.load_queue > 0 then
	JUMP TO BLOCK #46
	else
	JUMP TO BLOCK #47
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #46 344-344, warpins: 1 ---
	--- END OF BLOCK #46 ---




	-- Decompilation error in this vicinity:
	--- BLOCK #47 345-362, warpins: 1 ---
	log.end_time("textures")

	self.queue_load_start_time = nil
	self.progress = 1
	self.groups_total = 0
	self.queue_load_total_images = 0
	self.queue_load_done_images = 0
	self.image_name_queue = {}

	return true
	--- END OF BLOCK #47 ---



end

function image_db:queue_load_atlas(ref_scale, path, name)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-22, warpins: 1 ---
	log.debug("queued %s/%s-%.6f", path, name, ref_scale)
	table.insert(self.load_queue, {
		ref_scale,
		path,
		name
	})

	self.groups_total = self.groups_total + 1
	--- END OF BLOCK #0 ---

	if #self.load_queue == 1 then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #3
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 23-25, warpins: 1 ---
	--- END OF BLOCK #1 ---

	slot4 = if not self.load_queue_current then
	JUMP TO BLOCK #2
	else
	JUMP TO BLOCK #3
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #2 26-29, warpins: 1 ---
	self.progress = 0
	self.groups_done = 0

	--- END OF BLOCK #2 ---

	FLOW; TARGET BLOCK #3



	-- Decompilation error in this vicinity:
	--- BLOCK #3 30-30, warpins: 3 ---
	return
	--- END OF BLOCK #3 ---



end

function image_db:unload_atlas(name, ref_scale)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-2, warpins: 1 ---
	--- END OF BLOCK #0 ---

	slot2 = if not ref_scale then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 3-3, warpins: 1 ---
	ref_scale = 1
	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 4-13, warpins: 2 ---
	local name_scale = string.format("%s-%.6f", name, ref_scale)

	--- END OF BLOCK #2 ---

	slot4 = if not self.atlas_uses[name_scale] then
	JUMP TO BLOCK #3
	else
	JUMP TO BLOCK #4
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #3 14-19, warpins: 1 ---
	log.info("atlas %s does not exist", name_scale)

	return

	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #4 20-29, warpins: 2 ---
	self.atlas_uses[name_scale] = self.atlas_uses[name_scale] - 1

	--- END OF BLOCK #4 ---

	if self.atlas_uses[name_scale] > 0 then
	JUMP TO BLOCK #5
	else
	JUMP TO BLOCK #6
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #5 30-35, warpins: 1 ---
	log.debug("atlas %s still in use", name)

	return

	--- END OF BLOCK #5 ---

	FLOW; TARGET BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #6 36-50, warpins: 2 ---
	log.debug("unloading atlas %s-%.6f", name, ref_scale)

	self.atlas_uses[name_scale] = nil
	local remove_frames = {}
	local remove_images = {}

	--- END OF BLOCK #6 ---

	for k, f in pairs(self.db_atlas)

	LOOP BLOCK #7
	GO OUT TO BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #7 51-53, warpins: 1 ---
	--- END OF BLOCK #7 ---

	if f.group == name_scale then
	JUMP TO BLOCK #8
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #8 54-61, warpins: 1 ---
	table.insert(remove_frames, k)

	remove_images[f.atlas] = true
	--- END OF BLOCK #8 ---

	FLOW; TARGET BLOCK #9



	-- Decompilation error in this vicinity:
	--- BLOCK #9 62-63, warpins: 3 ---
	--- END OF BLOCK #9 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #10 64-68, warpins: 1 ---
	local removed_images_count = 0

	--- END OF BLOCK #10 ---

	for k, _ in pairs(remove_images)


	LOOP BLOCK #11
	GO OUT TO BLOCK #13



	-- Decompilation error in this vicinity:
	--- BLOCK #11 69-72, warpins: 1 ---
	self.db_images[k] = nil
	removed_images_count = removed_images_count + 1

	--- END OF BLOCK #11 ---

	FLOW; TARGET BLOCK #12



	-- Decompilation error in this vicinity:
	--- BLOCK #12 73-74, warpins: 2 ---
	--- END OF BLOCK #12 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #13 75-78, warpins: 1 ---
	--- END OF BLOCK #13 ---

	for _, k in pairs(remove_frames)


	LOOP BLOCK #14
	GO OUT TO BLOCK #16



	-- Decompilation error in this vicinity:
	--- BLOCK #14 79-81, warpins: 1 ---
	self.db_atlas[k] = nil

	--- END OF BLOCK #14 ---

	FLOW; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #15 82-83, warpins: 2 ---
	--- END OF BLOCK #15 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #13



	-- Decompilation error in this vicinity:
	--- BLOCK #16 84-93, warpins: 1 ---
	log.debug(" removed #frames:%s #images:%s ", #remove_frames, removed_images_count)
	self:purge_atlas()

	return
	--- END OF BLOCK #16 ---



end

function image_db:purge_atlas()

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-5, warpins: 1 ---
	local used_images = {}

	--- END OF BLOCK #0 ---

	for k, f in pairs(self.db_atlas)


	LOOP BLOCK #1
	GO OUT TO BLOCK #3



	-- Decompilation error in this vicinity:
	--- BLOCK #1 6-8, warpins: 1 ---
	used_images[f.atlas] = true
	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 9-10, warpins: 2 ---
	--- END OF BLOCK #2 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #0



	-- Decompilation error in this vicinity:
	--- BLOCK #3 11-15, warpins: 1 ---
	local remove_images = {}

	--- END OF BLOCK #3 ---

	for k, v in pairs(self.db_images)

	LOOP BLOCK #4
	GO OUT TO BLOCK #7



	-- Decompilation error in this vicinity:
	--- BLOCK #4 16-18, warpins: 1 ---
	--- END OF BLOCK #4 ---

	slot8 = if not used_images[k] then
	JUMP TO BLOCK #5
	else
	JUMP TO BLOCK #6
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #5 19-23, warpins: 1 ---
	table.insert(remove_images, k)
	--- END OF BLOCK #5 ---

	FLOW; TARGET BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #6 24-25, warpins: 3 ---
	--- END OF BLOCK #6 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #3



	-- Decompilation error in this vicinity:
	--- BLOCK #7 26-29, warpins: 1 ---
	--- END OF BLOCK #7 ---

	for _, v in pairs(remove_images)


	LOOP BLOCK #8
	GO OUT TO BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #8 30-32, warpins: 1 ---
	self.db_images[v] = nil

	--- END OF BLOCK #8 ---

	FLOW; TARGET BLOCK #9



	-- Decompilation error in this vicinity:
	--- BLOCK #9 33-34, warpins: 2 ---
	--- END OF BLOCK #9 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #7



	-- Decompilation error in this vicinity:
	--- BLOCK #10 35-40, warpins: 1 ---
	log.debug("  purged #images:%s", #remove_images)

	return
	--- END OF BLOCK #10 ---



end

function image_db:preload_atlas(ref_scale, path, name)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-17, warpins: 1 ---
	local name_scale = string.format("%s-%.6f", name, ref_scale)

	log.debug("load atlas: %s,%s-%.6f", path, name, ref_scale)

	--- END OF BLOCK #0 ---

	slot5 = if self.atlas_uses[name_scale] then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 18-28, warpins: 1 ---
	self.atlas_uses[name_scale] = self.atlas_uses[name_scale] + 1

	log.debug("atlas %s already loaded", name)

	return

	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 29-40, warpins: 2 ---
	self.atlas_uses[name_scale] = 1

	table.insert(self.last_preloaded_group_names, name)

	self.progress = 0
	--- END OF BLOCK #2 ---

	slot1 = if not ref_scale then
	JUMP TO BLOCK #3
	else
	JUMP TO BLOCK #4
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #3 41-41, warpins: 1 ---
	ref_scale = 1
	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #4 42-52, warpins: 2 ---
	local group_file = path .. "/" .. name .. ".lua"

	--- END OF BLOCK #4 ---

	slot6 = if not FS.isFile(group_file)
	 then
	JUMP TO BLOCK #5
	else
	JUMP TO BLOCK #6
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #5 53-60, warpins: 1 ---
	log.error("atlas file %s not found for %s/%s", group_file, path, name)

	return

	--- END OF BLOCK #5 ---

	FLOW; TARGET BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #6 61-72, warpins: 2 ---
	local frames = FS.load(group_file)()
	local unique_frames = {}
	local image_names = {}
	local deferred_image_names = {}

	--- END OF BLOCK #6 ---

	for k, v in pairs(frames)

	LOOP BLOCK #7
	GO OUT TO BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #7 73-98, warpins: 1 ---
	log.paranoid("loading atlas-frame: %s - %s", v.a_name, k)

	v.group = name_scale
	v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[3], v.f_quad[4], v.a_size[1], v.a_size[2])
	--- END OF BLOCK #7 ---

	slot15 = if v.defer then
	JUMP TO BLOCK #8
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #8 99-102, warpins: 1 ---
	deferred_image_names[v.a_name] = true
	--- END OF BLOCK #8 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #9 103-105, warpins: 1 ---
	image_names[v.a_name] = true
	--- END OF BLOCK #9 ---

	FLOW; TARGET BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #10 106-151, warpins: 2 ---
	v.atlas = string.gsub(v.a_name, ".png$", "")
	v.atlas = string.gsub(v.atlas, ".lz4$", "")
	v.atlas = string.gsub(v.atlas, ".pkm$", "")
	v.atlas = string.gsub(v.atlas, ".ktx$", "")
	v.atlas = string.gsub(v.atlas, ".astc$", "")
	v.atlas = string.gsub(v.atlas, ".dds", "")

	--- END OF BLOCK #10 ---

	for _, a in ipairs(v.alias)


	LOOP BLOCK #11
	GO OUT TO BLOCK #13



	-- Decompilation error in this vicinity:
	--- BLOCK #11 152-152, warpins: 1 ---
	unique_frames[a] = v
	--- END OF BLOCK #11 ---

	FLOW; TARGET BLOCK #12



	-- Decompilation error in this vicinity:
	--- BLOCK #12 153-154, warpins: 2 ---
	--- END OF BLOCK #12 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #13 155-155, warpins: 1 ---
	v.ref_scale = ref_scale

	--- END OF BLOCK #13 ---

	FLOW; TARGET BLOCK #14



	-- Decompilation error in this vicinity:
	--- BLOCK #14 156-157, warpins: 2 ---
	--- END OF BLOCK #14 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #15 158-161, warpins: 1 ---
	--- END OF BLOCK #15 ---

	for k, v in pairs(unique_frames)


	LOOP BLOCK #16
	GO OUT TO BLOCK #18



	-- Decompilation error in this vicinity:
	--- BLOCK #16 162-162, warpins: 1 ---
	frames[k] = v
	--- END OF BLOCK #16 ---

	FLOW; TARGET BLOCK #17



	-- Decompilation error in this vicinity:
	--- BLOCK #17 163-164, warpins: 2 ---
	--- END OF BLOCK #17 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #18 165-174, warpins: 1 ---
	self.db_atlas = table.merge(self.db_atlas, frames)

	--- END OF BLOCK #18 ---

	for fn in pairs(deferred_image_names)


	LOOP BLOCK #19
	GO OUT TO BLOCK #21



	-- Decompilation error in this vicinity:
	--- BLOCK #19 175-227, warpins: 1 ---
	local key = string.gsub(fn, ".png$", "")
	key = string.gsub(key, ".lz4$", "")
	key = string.gsub(key, ".jpg$", "")
	key = string.gsub(key, ".pkm$", "")
	key = string.gsub(key, ".ktx$", "")
	key = string.gsub(key, ".astc$", "")
	key = string.gsub(key, ".dds$", "")
	self.db_images[key] = {
		[4] = fn,
		[5] = path
	}

	--- END OF BLOCK #19 ---

	FLOW; TARGET BLOCK #20



	-- Decompilation error in this vicinity:
	--- BLOCK #20 228-229, warpins: 2 ---
	--- END OF BLOCK #20 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #18



	-- Decompilation error in this vicinity:
	--- BLOCK #21 230-230, warpins: 1 ---
	return image_names
	--- END OF BLOCK #21 ---



end

function image_db:load_atlas(ref_scale, path, name, yielding)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-12, warpins: 1 ---
	local rt_start = love.timer.getTime()
	local image_names = self:preload_atlas(ref_scale, path, name)

	--- END OF BLOCK #0 ---

	slot6 = if not image_names then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 13-13, warpins: 1 ---
	return

	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 14-18, warpins: 2 ---
	local i = 0

	--- END OF BLOCK #2 ---

	for fn in pairs(image_names)


	LOOP BLOCK #3
	GO OUT TO BLOCK #6



	-- Decompilation error in this vicinity:
	--- BLOCK #3 19-33, warpins: 1 ---
	i = i + 1
	local key, im, w, h = image_db:load_image_file(fn, path)
	self.db_images[key] = {
		im,
		w,
		h
	}
	--- END OF BLOCK #3 ---

	slot4 = if yielding then
	JUMP TO BLOCK #4
	else
	JUMP TO BLOCK #5
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #4 34-43, warpins: 1 ---
	self.progress = i / #table.keys(image_names)

	coroutine.yield()

	--- END OF BLOCK #4 ---

	FLOW; TARGET BLOCK #5



	-- Decompilation error in this vicinity:
	--- BLOCK #5 44-45, warpins: 3 ---
	--- END OF BLOCK #5 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #6 46-60, warpins: 1 ---
	self.progress = 1

	log.info("Finished loading atlas %s/%s at scale %s (time:%s)", path, name, ref_scale, love.timer.getTime() - rt_start)

	return
	--- END OF BLOCK #6 ---



end

function image_db:load(ref_scale, custom_paths)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-2, warpins: 1 ---
	--- END OF BLOCK #0 ---

	slot1 = if not ref_scale then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 3-3, warpins: 1 ---
	ref_scale = 1
	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 4-5, warpins: 2 ---
	--- END OF BLOCK #2 ---

	slot3 = if not custom_paths then
	JUMP TO BLOCK #3
	else
	JUMP TO BLOCK #4
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #3 6-6, warpins: 1 ---
	local paths = {
		"images/ipad"
	}
	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #4 7-11, warpins: 2 ---
	local image_files = {}

	--- END OF BLOCK #4 ---

	for _, path in pairs(paths)


	LOOP BLOCK #5
	GO OUT TO BLOCK #14



	-- Decompilation error in this vicinity:
	--- BLOCK #5 12-19, warpins: 1 ---
	local files = FS.getDirectoryItems(path)
	--- END OF BLOCK #5 ---

	for i=1, #files, 1
	LOOP BLOCK #6
	GO OUT TO BLOCK #13


	-- Decompilation error in this vicinity:
	--- BLOCK #6 20-30, warpins: 2 ---
	local name = files[i]
	local f = path .. "/" .. name

	--- END OF BLOCK #6 ---

	slot17 = if FS.isFile(f)
	 then
	JUMP TO BLOCK #7
	else
	JUMP TO BLOCK #12
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #7 31-37, warpins: 1 ---
	--- END OF BLOCK #7 ---

	slot17 = if not string.match(f, ".png$")
	 then
	JUMP TO BLOCK #8
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #8 38-44, warpins: 1 ---
	--- END OF BLOCK #8 ---

	slot17 = if string.match(f, ".jpg$")

	 then
	JUMP TO BLOCK #9
	else
	JUMP TO BLOCK #12
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #9 45-63, warpins: 2 ---
	local key = string.gsub(name, ".png$", "")
	key = string.gsub(key, ".jpg$", "")
	local im = G.newImage(f)

	--- END OF BLOCK #9 ---

	slot18 = if not im then
	JUMP TO BLOCK #10
	else
	JUMP TO BLOCK #11
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #10 64-69, warpins: 1 ---
	log.error("Image %s could not be created", f)

	--- END OF BLOCK #10 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #12



	-- Decompilation error in this vicinity:
	--- BLOCK #11 70-78, warpins: 1 ---
	local w, h = im:getDimensions()
	self.db_images[key] = {
		im,
		w,
		h
	}

	--- END OF BLOCK #11 ---

	FLOW; TARGET BLOCK #12



	-- Decompilation error in this vicinity:
	--- BLOCK #12 79-79, warpins: 4 ---
	--- END OF BLOCK #12 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #5



	-- Decompilation error in this vicinity:
	--- BLOCK #13 80-81, warpins: 2 ---
	--- END OF BLOCK #13 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #14 82-85, warpins: 1 ---
	--- END OF BLOCK #14 ---

	for _, path in pairs(paths)


	LOOP BLOCK #15
	GO OUT TO BLOCK #30



	-- Decompilation error in this vicinity:
	--- BLOCK #15 86-93, warpins: 1 ---
	local files = FS.getDirectoryItems(path)
	--- END OF BLOCK #15 ---

	for i=1, #files, 1
	LOOP BLOCK #16
	GO OUT TO BLOCK #29


	-- Decompilation error in this vicinity:
	--- BLOCK #16 94-104, warpins: 2 ---
	local name = files[i]
	local f = path .. "/" .. name

	--- END OF BLOCK #16 ---

	slot17 = if FS.isFile(f)
	 then
	JUMP TO BLOCK #17
	else
	JUMP TO BLOCK #28
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #17 105-111, warpins: 1 ---
	--- END OF BLOCK #17 ---

	slot17 = if string.match(f, ".lua$")

	 then
	JUMP TO BLOCK #18
	else
	JUMP TO BLOCK #28
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #18 112-128, warpins: 1 ---
	local file_basename = string.gsub(name, ".lua$", "")
	local frames = require(path .. "." .. file_basename)
	local queue = {}

	--- END OF BLOCK #18 ---

	for k, v in pairs(frames)


	LOOP BLOCK #19
	GO OUT TO BLOCK #24



	-- Decompilation error in this vicinity:
	--- BLOCK #19 129-155, warpins: 1 ---
	v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[3], v.f_quad[4], v.a_size[1], v.a_size[2])
	v.atlas = string.gsub(v.a_name, ".png$", "")

	--- END OF BLOCK #19 ---

	for _, a in ipairs(v.alias)


	LOOP BLOCK #20
	GO OUT TO BLOCK #22



	-- Decompilation error in this vicinity:
	--- BLOCK #20 156-156, warpins: 1 ---
	queue[a] = v
	--- END OF BLOCK #20 ---

	FLOW; TARGET BLOCK #21



	-- Decompilation error in this vicinity:
	--- BLOCK #21 157-158, warpins: 2 ---
	--- END OF BLOCK #21 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #19



	-- Decompilation error in this vicinity:
	--- BLOCK #22 159-159, warpins: 1 ---
	v.ref_scale = ref_scale

	--- END OF BLOCK #22 ---

	FLOW; TARGET BLOCK #23



	-- Decompilation error in this vicinity:
	--- BLOCK #23 160-161, warpins: 2 ---
	--- END OF BLOCK #23 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #18



	-- Decompilation error in this vicinity:
	--- BLOCK #24 162-165, warpins: 1 ---
	--- END OF BLOCK #24 ---

	for k, v in pairs(queue)


	LOOP BLOCK #25
	GO OUT TO BLOCK #27



	-- Decompilation error in this vicinity:
	--- BLOCK #25 166-166, warpins: 1 ---
	frames[k] = v
	--- END OF BLOCK #25 ---

	FLOW; TARGET BLOCK #26



	-- Decompilation error in this vicinity:
	--- BLOCK #26 167-168, warpins: 2 ---
	--- END OF BLOCK #26 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #24



	-- Decompilation error in this vicinity:
	--- BLOCK #27 169-174, warpins: 1 ---
	self.db_atlas = table.merge(self.db_atlas, frames)

	--- END OF BLOCK #27 ---

	FLOW; TARGET BLOCK #28



	-- Decompilation error in this vicinity:
	--- BLOCK #28 175-175, warpins: 3 ---
	--- END OF BLOCK #28 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #29 176-177, warpins: 2 ---
	--- END OF BLOCK #29 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #14



	-- Decompilation error in this vicinity:
	--- BLOCK #30 178-182, warpins: 1 ---
	log.debug("finished loading image_db")

	return
	--- END OF BLOCK #30 ---



end

if DEBUG then

	-- Decompilation error in this vicinity:
	--- BLOCK #1 88-89, warpins: 1 ---
	function image_db:load_from_dir(ref_scale, path, group_name)

		-- Decompilation error in this vicinity:
		--- BLOCK #0 1-6, warpins: 1 ---
		--- END OF BLOCK #0 ---

		if love.system.getOS()

		 ~= "Windows" then
		JUMP TO BLOCK #1
		else
		JUMP TO BLOCK #2
		end



		-- Decompilation error in this vicinity:
		--- BLOCK #1 7-8, warpins: 1 ---
		slot4 = false
		--- END OF BLOCK #1 ---

		UNCONDITIONAL JUMP; TARGET BLOCK #3



		-- Decompilation error in this vicinity:
		--- BLOCK #2 9-9, warpins: 1 ---
		local is_windows = true
		--- END OF BLOCK #2 ---

		FLOW; TARGET BLOCK #3



		-- Decompilation error in this vicinity:
		--- BLOCK #3 10-11, warpins: 2 ---
		--- END OF BLOCK #3 ---

		slot4 = if is_windows then
		JUMP TO BLOCK #4
		else
		JUMP TO BLOCK #5
		end



		-- Decompilation error in this vicinity:
		--- BLOCK #4 12-13, warpins: 1 ---
		slot5 = "\\"
		--- END OF BLOCK #4 ---

		UNCONDITIONAL JUMP; TARGET BLOCK #6



		-- Decompilation error in this vicinity:
		--- BLOCK #5 14-14, warpins: 1 ---
		local SEP = "/"
		--- END OF BLOCK #5 ---

		FLOW; TARGET BLOCK #6



		-- Decompilation error in this vicinity:
		--- BLOCK #6 15-29, warpins: 2 ---
		local image_formats = {
			"png",
			"pkm",
			"dds",
			"ktx",
			"jpg"
		}

		function ls(path)

			-- Decompilation error in this vicinity:
			--- BLOCK #0 1-4, warpins: 1 ---
			local o = {}

			--- END OF BLOCK #0 ---

			slot2 = if is_windows then
			JUMP TO BLOCK #1
			else
			JUMP TO BLOCK #8
			end



			-- Decompilation error in this vicinity:
			--- BLOCK #1 5-15, warpins: 1 ---
			--- END OF BLOCK #1 ---

			for n in io.popen("dir /b \"" .. path .. "\""):lines()

			LOOP BLOCK #2
			GO OUT TO BLOCK #7



			-- Decompilation error in this vicinity:
			--- BLOCK #2 16-19, warpins: 1 ---
			--- END OF BLOCK #2 ---

			for _, k in pairs(image_formats)

			LOOP BLOCK #3
			GO OUT TO BLOCK #6



			-- Decompilation error in this vicinity:
			--- BLOCK #3 20-29, warpins: 1 ---
			--- END OF BLOCK #3 ---

			slot11 = if string.match(n, ".+" .. k .. "$")
			 then
			JUMP TO BLOCK #4
			else
			JUMP TO BLOCK #5
			end



			-- Decompilation error in this vicinity:
			--- BLOCK #4 30-34, warpins: 1 ---
			table.insert(o, n)
			--- END OF BLOCK #4 ---

			FLOW; TARGET BLOCK #5



			-- Decompilation error in this vicinity:
			--- BLOCK #5 35-36, warpins: 3 ---
			--- END OF BLOCK #5 ---

			UNCONDITIONAL JUMP; TARGET BLOCK #2



			-- Decompilation error in this vicinity:
			--- BLOCK #6 37-38, warpins: 2 ---
			--- END OF BLOCK #6 ---

			UNCONDITIONAL JUMP; TARGET BLOCK #1



			-- Decompilation error in this vicinity:
			--- BLOCK #7 39-39, warpins: 1 ---
			--- END OF BLOCK #7 ---

			UNCONDITIONAL JUMP; TARGET BLOCK #14



			-- Decompilation error in this vicinity:
			--- BLOCK #8 40-49, warpins: 1 ---
			--- END OF BLOCK #8 ---

			for n in io.popen("ls " .. path):lines()

			LOOP BLOCK #9
			GO OUT TO BLOCK #14



			-- Decompilation error in this vicinity:
			--- BLOCK #9 50-53, warpins: 1 ---
			--- END OF BLOCK #9 ---

			for _, k in pairs(image_formats)

			LOOP BLOCK #10
			GO OUT TO BLOCK #13



			-- Decompilation error in this vicinity:
			--- BLOCK #10 54-63, warpins: 1 ---
			--- END OF BLOCK #10 ---

			slot11 = if string.match(n, ".+" .. k .. "$")
			 then
			JUMP TO BLOCK #11
			else
			JUMP TO BLOCK #12
			end



			-- Decompilation error in this vicinity:
			--- BLOCK #11 64-68, warpins: 1 ---
			table.insert(o, n)

			--- END OF BLOCK #11 ---

			FLOW; TARGET BLOCK #12



			-- Decompilation error in this vicinity:
			--- BLOCK #12 69-70, warpins: 3 ---
			--- END OF BLOCK #12 ---

			UNCONDITIONAL JUMP; TARGET BLOCK #9



			-- Decompilation error in this vicinity:
			--- BLOCK #13 71-72, warpins: 2 ---
			--- END OF BLOCK #13 ---

			UNCONDITIONAL JUMP; TARGET BLOCK #8



			-- Decompilation error in this vicinity:
			--- BLOCK #14 73-73, warpins: 2 ---
			return o
			--- END OF BLOCK #14 ---



		end

		local name_scale = string.format("%s-%.6f", group_name, ref_scale)

		--- END OF BLOCK #6 ---

		for _, n in pairs(ls(path))


		LOOP BLOCK #7
		GO OUT TO BLOCK #10



		-- Decompilation error in this vicinity:
		--- BLOCK #7 30-40, warpins: 1 ---
		local fn = path .. SEP .. n
		local fh = io.open(fn, "rb")
		--- END OF BLOCK #7 ---

		slot14 = if fh then
		JUMP TO BLOCK #8
		else
		JUMP TO BLOCK #9
		end



		-- Decompilation error in this vicinity:
		--- BLOCK #8 41-101, warpins: 1 ---
		local fc = fh:read("*a")
		local fd = love.filesystem.newFileData(fc, n)
		local id = love.image.newImageData(fd)
		local im = G.newImage(id)
		local w, h = im:getDimensions()
		local key = string.gsub(n, ".png$", "")
		local v = {}
		v.size = {
			w,
			h
		}
		v.trim = {
			0,
			0,
			0,
			0
		}
		v.a_name = n
		v.a_size = {
			w,
			h
		}
		v.group = name_scale
		v.quad = G.newQuad(0, 0, w, h, w, h)
		v.atlas = key
		v.ref_scale = ref_scale
		self.db_atlas[key] = v
		self.db_images[key] = {
			im,
			w,
			h
		}
		--- END OF BLOCK #8 ---

		FLOW; TARGET BLOCK #9



		-- Decompilation error in this vicinity:
		--- BLOCK #9 102-103, warpins: 3 ---
		--- END OF BLOCK #9 ---

		UNCONDITIONAL JUMP; TARGET BLOCK #6



		-- Decompilation error in this vicinity:
		--- BLOCK #10 104-108, warpins: 1 ---
		self.atlas_uses[name_scale] = 1

		return
		--- END OF BLOCK #10 ---



	end
	--- END OF BLOCK #1 ---



end

function image_db:load_image_file(fn, path)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-10, warpins: 1 ---
	local f = path .. "/" .. fn

	--- END OF BLOCK #0 ---

	slot4 = if not FS.isFile(f)
	 then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 11-16, warpins: 1 ---
	log.error("not a valid file: %s", f)

	return

	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 17-23, warpins: 2 ---
	--- END OF BLOCK #2 ---

	slot4 = if not string.match(f, ".png$")
	 then
	JUMP TO BLOCK #3
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #3 24-30, warpins: 1 ---
	--- END OF BLOCK #3 ---

	slot4 = if not string.match(f, ".jpg$")
	 then
	JUMP TO BLOCK #4
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #4 31-37, warpins: 1 ---
	--- END OF BLOCK #4 ---

	slot4 = if not string.match(f, ".pkm$")
	 then
	JUMP TO BLOCK #5
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #5 38-44, warpins: 1 ---
	--- END OF BLOCK #5 ---

	slot4 = if not string.match(f, ".astc$")
	 then
	JUMP TO BLOCK #6
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #6 45-51, warpins: 1 ---
	--- END OF BLOCK #6 ---

	slot4 = if not string.match(f, ".dds$")
	 then
	JUMP TO BLOCK #7
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #7 52-58, warpins: 1 ---
	--- END OF BLOCK #7 ---

	slot4 = if not string.match(f, ".pkm.lz4$")
	 then
	JUMP TO BLOCK #8
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #8 59-65, warpins: 1 ---
	--- END OF BLOCK #8 ---

	slot4 = if string.match(f, ".ktx.lz4$")
	 then
	JUMP TO BLOCK #9
	else
	JUMP TO BLOCK #29
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #9 66-78, warpins: 7 ---
	log.paranoid("  loading image file %s", f)

	local compressed = false

	--- END OF BLOCK #9 ---

	slot5 = if not string.match(f, ".pkm$")
	 then
	JUMP TO BLOCK #10
	else
	JUMP TO BLOCK #13
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #10 79-85, warpins: 1 ---
	--- END OF BLOCK #10 ---

	slot5 = if not string.match(f, ".pkm.lz4$")
	 then
	JUMP TO BLOCK #11
	else
	JUMP TO BLOCK #13
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #11 86-92, warpins: 1 ---
	--- END OF BLOCK #11 ---

	slot5 = if not string.match(f, ".ktx$")
	 then
	JUMP TO BLOCK #12
	else
	JUMP TO BLOCK #13
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #12 93-99, warpins: 1 ---
	--- END OF BLOCK #12 ---

	slot5 = if string.match(f, ".ktx.lz4$")

	 then
	JUMP TO BLOCK #13
	else
	JUMP TO BLOCK #15
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #13 100-107, warpins: 4 ---
	compressed = true
	local supportedformats = love.graphics.getCompressedImageFormats()

	--- END OF BLOCK #13 ---

	slot6 = if not supportedformats.ETC1 then
	JUMP TO BLOCK #14
	else
	JUMP TO BLOCK #21
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #14 108-115, warpins: 1 ---
	log.error("ETC1 not supported. Could not load %s", f)

	return nil

	--- END OF BLOCK #14 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #21



	-- Decompilation error in this vicinity:
	--- BLOCK #15 116-122, warpins: 1 ---
	--- END OF BLOCK #15 ---

	slot5 = if string.match(f, ".astc$")

	 then
	JUMP TO BLOCK #16
	else
	JUMP TO BLOCK #18
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #16 123-130, warpins: 1 ---
	compressed = true
	local supportedformats = love.graphics.getCompressedImageFormats()

	--- END OF BLOCK #16 ---

	slot6 = if not supportedformats.ASTC4x4 then
	JUMP TO BLOCK #17
	else
	JUMP TO BLOCK #21
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #17 131-138, warpins: 1 ---
	log.error("ASTC not supported. Could not load %s", f)

	return nil

	--- END OF BLOCK #17 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #21



	-- Decompilation error in this vicinity:
	--- BLOCK #18 139-145, warpins: 1 ---
	--- END OF BLOCK #18 ---

	slot5 = if string.match(f, ".dds$")

	 then
	JUMP TO BLOCK #19
	else
	JUMP TO BLOCK #21
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #19 146-153, warpins: 1 ---
	compressed = true
	local supportedformats = love.graphics.getCompressedImageFormats()

	--- END OF BLOCK #19 ---

	slot6 = if not supportedformats.DXT3 then
	JUMP TO BLOCK #20
	else
	JUMP TO BLOCK #21
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #20 154-160, warpins: 1 ---
	log.error("DXT3 not supported. Could not load %s", f)

	return nil

	--- END OF BLOCK #20 ---

	FLOW; TARGET BLOCK #21



	-- Decompilation error in this vicinity:
	--- BLOCK #21 161-163, warpins: 7 ---
	local im = nil
	--- END OF BLOCK #21 ---

	slot4 = if compressed then
	JUMP TO BLOCK #22
	else
	JUMP TO BLOCK #25
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #22 164-170, warpins: 1 ---
	local imd = love.image.newCompressedData(f)

	--- END OF BLOCK #22 ---

	slot6 = if not imd then
	JUMP TO BLOCK #23
	else
	JUMP TO BLOCK #24
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #23 171-176, warpins: 1 ---
	log.error("Compressed image %s could not be loaded", f)

	return

	--- END OF BLOCK #23 ---

	FLOW; TARGET BLOCK #24



	-- Decompilation error in this vicinity:
	--- BLOCK #24 177-182, warpins: 2 ---
	im = G.newImage(imd)
	--- END OF BLOCK #24 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #26



	-- Decompilation error in this vicinity:
	--- BLOCK #25 183-187, warpins: 1 ---
	im = G.newImage(f)

	--- END OF BLOCK #25 ---

	FLOW; TARGET BLOCK #26



	-- Decompilation error in this vicinity:
	--- BLOCK #26 188-189, warpins: 2 ---
	--- END OF BLOCK #26 ---

	slot5 = if not im then
	JUMP TO BLOCK #27
	else
	JUMP TO BLOCK #28
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #27 190-195, warpins: 1 ---
	log.error("Image %s could not be created", f)

	--- END OF BLOCK #27 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #29



	-- Decompilation error in this vicinity:
	--- BLOCK #28 196-251, warpins: 1 ---
	local w, h = im:getDimensions()
	local key = string.gsub(fn, ".png$", "")
	key = string.gsub(key, ".lz4$", "")
	key = string.gsub(key, ".jpg$", "")
	key = string.gsub(key, ".pkm$", "")
	key = string.gsub(key, ".ktx$", "")
	key = string.gsub(key, ".astc$", "")
	key = string.gsub(key, ".dds$", "")

	return key, im, w, h
	--- END OF BLOCK #28 ---

	FLOW; TARGET BLOCK #29



	-- Decompilation error in this vicinity:
	--- BLOCK #29 252-252, warpins: 3 ---
	return
	--- END OF BLOCK #29 ---



end

function image_db:add_image(name, image, group, scale)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-2, warpins: 1 ---
	--- END OF BLOCK #0 ---

	slot4 = if not scale then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 3-3, warpins: 1 ---
	scale = 1
	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 4-59, warpins: 2 ---
	local name_scale = string.format("%s-%.6f", group, scale)
	local w, h = image:getDimensions()
	v = {}
	v.size = {
		w,
		h
	}
	v.trim = {
		0,
		0,
		0,
		0
	}
	v.a_name = name
	v.a_size = {
		w,
		h
	}
	v.group = name_scale
	v.quad = G.newQuad(0, 0, w, h, w, h)
	v.atlas = name
	v.ref_scale = scale
	self.db_atlas[name] = v
	self.db_images[name] = {
		image,
		w,
		h
	}
	--- END OF BLOCK #2 ---

	slot8 = if not self.atlas_uses[name_scale] then
	JUMP TO BLOCK #3
	else
	JUMP TO BLOCK #4
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #3 60-62, warpins: 1 ---
	self.atlas_uses[name_scale] = 1

	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #4 63-63, warpins: 2 ---
	return
	--- END OF BLOCK #4 ---



end

function image_db:remove_image(name)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-7, warpins: 1 ---
	self.db_images[name] = nil
	self.db_atlas[name] = nil

	return
	--- END OF BLOCK #0 ---



end

function image_db:load_default_atlas()

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-3, warpins: 1 ---
	--- END OF BLOCK #0 ---

	slot1 = if self._default_atlas_loaded then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 4-4, warpins: 1 ---
	return

	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 5-8, warpins: 2 ---
	--- END OF BLOCK #2 ---

	for name, color in pairs(DEFAULT_ATLAS_1X1_SPRITES)


	LOOP BLOCK #3
	GO OUT TO BLOCK #5



	-- Decompilation error in this vicinity:
	--- BLOCK #3 9-34, warpins: 1 ---
	local id = love.image.newImageData(1, 1)

	id:setPixel(0, 0, color[1], color[2], color[3], color[4])

	local im = G.newImage(id)

	self:add_image(name, im, IMAGE_DB_DEFAULT_ATLAS_GROUP, 1)

	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #4 35-36, warpins: 2 ---
	--- END OF BLOCK #4 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #5 37-39, warpins: 1 ---
	self._default_atlas_loaded = true

	return
	--- END OF BLOCK #5 ---



end

function image_db:unload_default_atlas()

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-3, warpins: 1 ---
	--- END OF BLOCK #0 ---

	slot1 = if not self._default_atlas_loaded then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #2
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 4-4, warpins: 1 ---
	return

	--- END OF BLOCK #1 ---

	FLOW; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #2 5-8, warpins: 2 ---
	--- END OF BLOCK #2 ---

	for name in pairs(DEFAULT_ATLAS_1X1_SPRITES)

	LOOP BLOCK #3
	GO OUT TO BLOCK #5



	-- Decompilation error in this vicinity:
	--- BLOCK #3 9-12, warpins: 1 ---
	self:remove_image(name)

	--- END OF BLOCK #3 ---

	FLOW; TARGET BLOCK #4



	-- Decompilation error in this vicinity:
	--- BLOCK #4 13-14, warpins: 2 ---
	--- END OF BLOCK #4 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #2



	-- Decompilation error in this vicinity:
	--- BLOCK #5 15-29, warpins: 1 ---
	local name_scale = string.format("%s-%.6f", IMAGE_DB_DEFAULT_ATLAS_GROUP, 1)
	self.atlas_uses[name_scale] = nil

	self:purge_atlas()

	self._default_atlas_loaded = false

	return
	--- END OF BLOCK #5 ---



end

function image_db:i(name, optional)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-6, warpins: 1 ---
	local i = self.db_images[name]
	--- END OF BLOCK #0 ---

	slot4 = if self.db_images[name] then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #6
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 7-9, warpins: 1 ---
	--- END OF BLOCK #1 ---

	if i[1] == nil then
	JUMP TO BLOCK #2
	else
	JUMP TO BLOCK #5
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #2 10-12, warpins: 1 ---
	--- END OF BLOCK #2 ---

	slot4 = if i[4] then
	JUMP TO BLOCK #3
	else
	JUMP TO BLOCK #5
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #3 13-15, warpins: 1 ---
	--- END OF BLOCK #3 ---

	slot4 = if i[5] then
	JUMP TO BLOCK #4
	else
	JUMP TO BLOCK #5
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #4 16-31, warpins: 1 ---
	local key, im, w, h = self:load_image_file(i[4], i[5])
	self.db_images[name] = {
		im,
		w,
		h
	}

	return im, w, h
	--- END OF BLOCK #4 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #5 32-36, warpins: 3 ---
	return i[1], i[2], i[3]
	--- END OF BLOCK #5 ---

	UNCONDITIONAL JUMP; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #6 37-38, warpins: 1 ---
	--- END OF BLOCK #6 ---

	slot1 = if not name then
	JUMP TO BLOCK #7
	else
	JUMP TO BLOCK #8
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #7 39-42, warpins: 1 ---
	--- END OF BLOCK #7 ---

	slot4 = if not self.missing_images["nil"] then
	JUMP TO BLOCK #8
	else
	JUMP TO BLOCK #9
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #8 43-46, warpins: 2 ---
	--- END OF BLOCK #8 ---

	slot4 = if self.missing_images[name] then
	JUMP TO BLOCK #9
	else
	JUMP TO BLOCK #10
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #9 47-48, warpins: 2 ---
	return nil

	--- END OF BLOCK #9 ---

	FLOW; TARGET BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #10 49-50, warpins: 2 ---
	--- END OF BLOCK #10 ---

	slot2 = if not optional then
	JUMP TO BLOCK #11
	else
	JUMP TO BLOCK #12
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #11 51-58, warpins: 1 ---
	log.error("Image %s not found in the images db\n%s", name, self:get_short_stats())

	--- END OF BLOCK #11 ---

	FLOW; TARGET BLOCK #12



	-- Decompilation error in this vicinity:
	--- BLOCK #12 59-61, warpins: 2 ---
	slot4 = self.missing_images
	--- END OF BLOCK #12 ---

	slot5 = if not name then
	JUMP TO BLOCK #13
	else
	JUMP TO BLOCK #14
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #13 62-62, warpins: 1 ---
	slot5 = "nil"
	--- END OF BLOCK #13 ---

	FLOW; TARGET BLOCK #14



	-- Decompilation error in this vicinity:
	--- BLOCK #14 63-66, warpins: 2 ---
	slot4[slot5] = true

	return nil
	--- END OF BLOCK #14 ---

	FLOW; TARGET BLOCK #15



	-- Decompilation error in this vicinity:
	--- BLOCK #15 67-67, warpins: 3 ---
	return
	--- END OF BLOCK #15 ---



end

function image_db:s(name, optional)

	-- Decompilation error in this vicinity:
	--- BLOCK #0 1-5, warpins: 1 ---
	local s = self.db_atlas[name]
	--- END OF BLOCK #0 ---

	slot4 = if DBG_REPLACE_MISSING_TEXTURES then
	JUMP TO BLOCK #1
	else
	JUMP TO BLOCK #3
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #1 6-7, warpins: 1 ---
	--- END OF BLOCK #1 ---

	slot3 = if not s then
	JUMP TO BLOCK #2
	else
	JUMP TO BLOCK #3
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #2 8-14, warpins: 1 ---
	s = self.db_atlas._debug_textures_missing

	log.error("DBG_REPLACE_MISSING_TEXTURES: replaced %s", name)

	--- END OF BLOCK #2 ---

	FLOW; TARGET BLOCK #3



	-- Decompilation error in this vicinity:
	--- BLOCK #3 15-16, warpins: 3 ---
	--- END OF BLOCK #3 ---

	slot3 = if not s then
	JUMP TO BLOCK #4
	else
	JUMP TO BLOCK #13
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #4 17-18, warpins: 1 ---
	--- END OF BLOCK #4 ---

	slot1 = if not name then
	JUMP TO BLOCK #5
	else
	JUMP TO BLOCK #6
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #5 19-22, warpins: 1 ---
	--- END OF BLOCK #5 ---

	slot4 = if not self.missing_sprites["nil"] then
	JUMP TO BLOCK #6
	else
	JUMP TO BLOCK #7
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #6 23-26, warpins: 2 ---
	--- END OF BLOCK #6 ---

	slot4 = if self.missing_sprites[name] then
	JUMP TO BLOCK #7
	else
	JUMP TO BLOCK #8
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #7 27-28, warpins: 2 ---
	return nil

	--- END OF BLOCK #7 ---

	FLOW; TARGET BLOCK #8



	-- Decompilation error in this vicinity:
	--- BLOCK #8 29-30, warpins: 2 ---
	--- END OF BLOCK #8 ---

	slot2 = if not optional then
	JUMP TO BLOCK #9
	else
	JUMP TO BLOCK #10
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #9 31-38, warpins: 1 ---
	log.error("Sprite %s was not found in the atlas db.\n%s", name, self:get_short_stats())

	--- END OF BLOCK #9 ---

	FLOW; TARGET BLOCK #10



	-- Decompilation error in this vicinity:
	--- BLOCK #10 39-41, warpins: 2 ---
	slot4 = self.missing_sprites
	--- END OF BLOCK #10 ---

	slot5 = if not name then
	JUMP TO BLOCK #11
	else
	JUMP TO BLOCK #12
	end



	-- Decompilation error in this vicinity:
	--- BLOCK #11 42-42, warpins: 1 ---
	slot5 = "nil"
	--- END OF BLOCK #11 ---

	FLOW; TARGET BLOCK #12



	-- Decompilation error in this vicinity:
	--- BLOCK #12 43-46, warpins: 2 ---
	slot4[slot5] = true

	return nil
	--- END OF BLOCK #12 ---

	FLOW; TARGET BLOCK #13



	-- Decompilation error in this vicinity:
	--- BLOCK #13 47-47, warpins: 2 ---
	return s
	--- END OF BLOCK #13 ---



end

return image_db
