G = vim.api.nvim_set_var

function K(mode, lhs, rhs, opts)
	opts = opts or {}

	-- Warn if description is missing (required for which-key integration)
	if not opts.desc then
		local info = debug.getinfo(2, "Sl")
		local file = info.source:gsub("^@", ""):gsub(".*/", "")
		vim.notify(
			string.format("[%s:%d] Keymap '%s' missing desc (required for which-key)", file, info.currentline, lhs),
			vim.log.levels.WARN
		)
	end

	if opts.noremap == nil then
		opts.noremap = true
	end

	-- Expand "" mode to the modes it actually applies to
	local modes = type(mode) == "table" and mode or { mode }
	local expanded_modes = {}
	for _, m in ipairs(modes) do
		if m == "" then
			-- "" applies to normal, visual, select, and operator-pending
			vim.list_extend(expanded_modes, { "n", "v", "s", "o" })
		else
			table.insert(expanded_modes, m)
		end
	end

	-- Normalize key notation for case-insensitive comparison
	local function normalize_key(key)
		return key:gsub("<[Cc]%-", "<c-"):gsub("<[Cc][Rr]>", "<cr>")
	end

	-- Check if mapping already exists (user-defined or vim default)
	local found_existing = false
	local normalized_lhs = normalize_key(lhs)
	for _, m in ipairs(expanded_modes) do
		-- Check user-defined mappings
		local existing = vim.fn.maparg(lhs, m, false, true)
		local is_user_mapped = existing and existing.lhs == lhs

		-- Check vim defaults (with normalized comparison)
		local defaults_for_mode = VIM_DEFAULTS[m] or {}
		local is_vim_default = false
		for _, default_key in ipairs(defaults_for_mode) do
			if normalize_key(default_key) == normalized_lhs then
				is_vim_default = true
				break
			end
		end

		if is_user_mapped or is_vim_default then
			found_existing = true
			if not opts.overwrite then
				-- Get caller info
				local info = debug.getinfo(2, "Sl")
				local file = info.source:gsub("^@", ""):gsub(".*/", "")
				local source = is_user_mapped and "user mapping" or "vim default"
				vim.notify(
					string.format(
						"[%s:%d] Keymap conflict: '%s' (mode '%s') overwrites %s. Pass `overwrite = true` if intentional.",
						file,
						info.currentline,
						lhs,
						m,
						source
					),
					vim.log.levels.WARN
				)
			end
		end
	end

	-- If overwrite was specified but nothing was actually overwritten, warn
	if opts.overwrite and not found_existing then
		local info = debug.getinfo(2, "Sl")
		local file = info.source:gsub("^@", ""):gsub(".*/", "")
		local mode_str = type(mode) == "table" and table.concat(mode, ",") or mode
		vim.notify(
			string.format(
				"[%s:%d] Unnecessary overwrite=true: '%s' (mode '%s') has no existing mapping",
				file,
				info.currentline,
				lhs,
				mode_str
			),
			vim.log.levels.WARN
		)
	end

	-- Remove overwrite from opts before passing to vim.keymap.set
	local final_opts = vim.tbl_extend("force", opts, {})
	final_opts.overwrite = nil
	vim.keymap.set(mode, lhs, rhs, final_opts)
end
