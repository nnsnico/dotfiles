module mycmd

import os
import utils { response_err, response_progress }

@[noinit]
struct Command {
pub:
	name     string @[required]
	cmd_path string @[required]
}

pub enum WithPrint {
	with_print
	no_print
}

pub fn create_command(str string) !Command {
	path := os.execute_opt('which ${str}') or { return error('Not found command: ${str}') }.output.trim('\n')

	return Command{
		name: str
		cmd_path: path
	}
}

pub fn (c Command) exec_with_print(with_print WithPrint, sub_command_and_options ...string) !string {
	command_with_options := sub_command_and_options.join(' ')
	full_cmd := '${c.cmd_path} ${command_with_options}'
	result := match with_print {
		.with_print {
			println(response_progress(full_cmd))
			os.execute(full_cmd)
		}
		.no_print {
			os.execute(full_cmd)
		}
	}
	return if result.exit_code == 0 {
		result.output.trim('\n')
	} else {
		error(response_err("Can't execute cmd: `${full_cmd}`, exit_code ${result.exit_code}"))
	}
}
