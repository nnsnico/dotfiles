module mycmd

import cli
import os
import utils { response_err, response_ok }

const target_path = '/private/etc/sudoers.d/yabai'

pub fn run_yabai_path(command cli.Command) ! {
	$if !macos {
		eprintln(response_err('This command is only available on macos'))
		exit(1)
	}

	// TODO: `whoami`, `logname`, `echo $USER` with root are not working...
	who := create_command('who')!.exec_with_print(.no_print) or {
		eprintln(err.str())
		exit(1)
	}
	user := who.split(' ')[0]
	yabai_path := create_command('yabai') or {
		eprintln(err.str())
		exit(1)
	}
	checksum := create_command('shasum')!.exec_with_print(.no_print, '-a', '256', '${yabai_path.cmd_path}')!

	yabai_sudoer_config := '${user} ALL=(root) NOPASSWD: sha256:${checksum} --load-sa'

	flag := flags['output']
	is_dry_run := command.flags.get_bool(flag.name)!
	if is_dry_run {
		println(yabai_sudoer_config)
	} else {
		mut target_file := os.create(target_path) or {
			eprintln(response_err("You don't have permission to access the file"))
			exit(1)
		}

		println('Write config to `${target_path}` ..')

		os.write_file(target_path, yabai_sudoer_config)!

		println(response_ok('Writing completed!'))

		target_file.close()
	}
}
