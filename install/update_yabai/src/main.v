module main

import os
import term
import cli

const target_path = "/private/etc/sudoers.d/yabai"

fn main() {
	mut app := cli.Command{
		name: 'update_yabai'
		description: 'update sudoer script for yabai'
		version: '0.1'
		execute: fn (cmd cli.Command) ! {
			user := os.loginname()!
			yabai_path := exec_panicable('which yabai') or {
				eprintln(term.red(err.str()))
				exit(1)
			}
			checksum := exec_panicable('shasum -a 256 ${yabai_path}') or {
				eprintln(term.red(err.str()))
				exit(1)
			}

			mut target_file := os.create(target_path) or {
				eprintln(term.red("You don't have permission to access the file"))
				exit(1)
			}

			yabai_sudoer_config := '${user} ALL=(root) NOPASSWD: sha256:${checksum} --load-sa'

			println('Write config to `${target_path}` ..')

			os.write_file(target_path, yabai_sudoer_config)!

			target_file.close()

			println(term.ok_message("Writing completed!"))

			return
		}
		disable_man: true
		posix_mode: true
	}

	app.setup()
	app.parse(os.args)
}

fn exec_panicable(cmd string) !string {
	result := os.execute(cmd)
	return if result.exit_code == 0 {
		result.output.replace('\n', '')
	} else {
		error("Can't execute cmd: ${cmd}, exit_code ${result.exit_code}")
	}
}
