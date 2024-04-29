#!/usr/bin/env -S v

module main

import os
import cli
import mycmd
import v.vmod

const manifest = vmod.decode(@VMOD_FILE) or { panic(err) }

mut app := cli.Command{
	name: manifest.name
	description: manifest.description
	version: manifest.version
	posix_mode: true
	defaults: struct {
		man: false
	}
}

app.add_command(cli.Command{
	name: 'yabai-path'
	description: 'Update sudoer script for yabai'
	execute: mycmd.run_yabai_path
	flags: [
		mycmd.flags['output'],
	]
})

app.add_command(cli.Command{
	name: 'packages'
	description: 'Update all packages in Homebrew'
	execute: mycmd.run_update_packages
})

app.setup()
app.parse(os.args)
