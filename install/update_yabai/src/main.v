module main

import arrays
import os
import term
import cli

const target_path = "/private/etc/sudoers.d/yabai"

fn main() {
	dry_run_flag := cli.Flag{
		flag: cli.FlagType.bool
		name: 'dry'
		abbrev: 'd'
		description: 'Prints the command to be executed.'
	}

	mut app := cli.Command{
		name: 'update_yabai'
		description: 'update sudoer script for yabai'
		version: '0.1'
		flags: [
			dry_run_flag
		]
		execute: fn [dry_run_flag] (cmd cli.Command) ! {
			if os.user_os() != 'macos' {
				eprintln(term.red('This command is only available on macos'))
				exit(1)
			}

			// TODO: `whoami`, `logname`, `echo $USER` with root are not working...
			user := exec_panicable('who | awk \'{print \$1\'}') or {
				eprintln(term.red(err.str()))
				exit(1)
			}
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

			is_dry_run := arrays.find_first(
				cmd.flags,
				fn [dry_run_flag] (elem cli.Flag) bool {
					return elem.name == dry_run_flag.name
				}
			) or {
				// Unreachable
				panic(err)
			}.get_bool() or {
				// Unreachable
				eprintln(term.red(err.str()))
				exit(1)
			}

			if is_dry_run {
				println(yabai_sudoer_config)
			} else {
				println('Write config to `${target_path}` ..')

				os.write_file(target_path, yabai_sudoer_config)!

				println(term.ok_message("Writing completed!"))
			}

			target_file.close()

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
