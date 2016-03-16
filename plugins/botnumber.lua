do

function run(msg, matches)
send_contact(get_receiver(msg), "+989378914486", "Avira", "Bot", ok_cb, false)
end

return {
patterns = {
"^!botnumber$"

},
run = run
}

end
--Copyright; @mohammadarak
--Persian Translate; @mohammadarak
--ch : @aviratgl
--کپی بدون ذکر منبع حرام است
