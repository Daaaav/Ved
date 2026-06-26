-- httpstest/elements

local downloader = ved_require("downloader")

local sha512_ok = love.data.encode("string", "hex", love.data.hash("sha512", "ok"))

local function test_name(name)
	return function()
		downloader.request(
			"test",
			"test_" .. name,
			"https://tolp.nl/test39/" .. name .. ".txt",
			sha512_ok, 2, {}
		)
	end
end

return {
	HorizontalListContainer(
		{
			Spacer(24, 0), -- Left padding
			ListContainer(
				{
					Text("HTTPS test"),
					Spacer(),
					WrappedText("A normal download directly pointing to an \"ok\" file"),
					LabelButton("Expect PASS", test_name("normal")),
					Spacer(),
					WrappedText("A nonexistent file (404 expected)"),
					LabelButton("Expect FAIL", test_name("nonexistent")),
					Spacer(),
					WrappedText("A 302 redirect to a different URL"),
					LabelButton("Expect PASS", test_name("redirect_from")),
					Spacer(),
				}, {}, nil, nil, ALIGN.LEFT, 24, 10
			)
		}, {}, nil, nil, VALIGN.TOP
	)
}
