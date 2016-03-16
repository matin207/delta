local function save_filter(msg, name, value)
	local hash = nil
	if msg.to.type == 'channel' then
		hash = 'chat:'..msg.to.id..':filters'
	end
	if msg.to.type == 'user' then
		return 'فقط مخصوص سوپرگروه می باشد'
	end
	if hash then
		redis:hset(hash, name, value)
		return "کلمه به لیست فیلترینگ اضافه شد"
	end
end

local function get_filter_hash(msg)
	if msg.to.type == 'channel' then
		return 'chat:'..msg.to.id..':filters'
	end
end 

local function list_filter(msg)
	if msg.to.type == 'user' then
		return 'فقط مخصوص صوپرگروه می باشد'
	end
	local hash = get_filter_hash(msg)
	if hash then
		local names = redis:hkeys(hash)
		local text = 'Sencured Wordes:\n\n'
		for i=1, #names do
			text = text..'➡️ '..names[i]..'\n'
		end
		return text
	end
end

local function get_filter(msg, var_name)
	local hash = get_filter_hash(msg)
	if hash then
		local value = redis:hget(hash, var_name)
		if value == 'msg' then
					delete_msg(msg.id, ok_cb, false)
			return 'WARNING!\nDon\'nt Use it!'
		elseif value == 'kick' then
			send_large_msg('channel#id'..msg.to.id, "BBye xD")
			channel_kick_user('channel#id'..msg.to.id, 'user#id'..msg.from.id, ok_cb, true)
						delete_msg(msg.id, ok_cb, false)
		end
	end
end

local function get_filter_act(msg, var_name)
	local hash = get_filter_hash(msg)
	if hash then
		local value = redis:hget(hash, var_name)
		if value == 'msg' then
			return 'اخطار کلمه فیلتر می باشد'
		elseif value == 'kick' then
			return 'شما کیک شدید'
		elseif value == 'none' then
			return 'کلمه خارج از فیلترینگ است'
		end
	end
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
	if matches[1] == "ilterlist" then
		return list_filter(msg)
	elseif matches[1] == "ilter" and matches[2] == "war1324jadlkhrou2aisn" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "شما مدیر نمی باشید"
			else
				local value = 'msg'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
	elseif matches[1] == "ilter" and matches[2] == "in" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "شما مدیر نمی باشید"
			else
				local value = 'kick'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
	elseif matches[1] == "ilter" and matches[2] == "out" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "شما مدیر نمی باشید"
			else
				local value = 'none'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
		
			elseif matches[1] == "ilter" and matches[2] == "clean" then
		if data[tostring(msg.to.id)] then
			local settings = data[tostring(msg.to.id)]['settings']
			if not is_momod(msg) then
				return "شما مدیر نمی باشید"
			else
				local value = 'none'
				local name = string.sub(matches[3]:lower(), 1, 1000)
				local text = save_filter(msg, name, value)
				return text
			end
		end
		
	elseif matches[1] == "ilter" and matches[2] == "about" then
		return get_filter_act(msg, matches[3]:lower())
	else
		if is_sudo(msg) then
			return
		elseif is_admin(msg) then
			return
		elseif is_momod(msg) then
			return
		elseif tonumber(msg.from.id) == tonumber(our_id) then
			return
		else
			return get_filter(msg, msg.text:lower())
		end
	end
end

return {
	patterns = {
		"^[!/][Ff](ilter) (.+) (.*)$",
		"^[!/][Ff](ilterlist)$",
		"(.*)",
	},
	run = run
}
-- مدیر : @mohammadarak
-- ربات : @avirabot
-- هر گونه کپی برداری بدون ذکر منبع حرام است 
