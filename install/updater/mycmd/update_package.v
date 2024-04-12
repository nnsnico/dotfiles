module mycmd

import cli
import os
import utils { response_err, response_ok, response_warn }

enum Answer {
	yes
	no
	others
}

enum UpdatePackageType {
	normal
	yabai
}

pub fn run_update_packages(command cli.Command) ! {
	brew := create_command('brew') or {
		eprintln(response_err(err.str()))
		exit(1)
	}

	brew.exec_with_print('update', .with_print) or {
		eprintln(response_err(err.str()))
		exit(1)
	}

	outdated_list := brew.exec_with_print('outdated --quiet', .with_print) or {
		eprintln(response_err(err.str()))
		exit(1)
	}.split('\n').filter(fn (s string) bool {
		return !s.is_blank()
	})

	package_list := outdated_list.map(fn (s string) UpdatePackageType {
		return parse_package_type(s)
	})

	if package_list.len == 0 {
		println(response_ok('No package updates'))
		exit(0)
	} else {
		println(response_ok('Update the following packages'))
		for p in outdated_list {
			println(response_ok('\t·${p}'))
		}
	}

	brew.update_all(package_list) or {
		eprintln(response_err(err.str()))
		exit(1)
	}

	println(response_ok('Package updates are complete!'))
}

fn parse_package_type(str string) UpdatePackageType {
	return match true {
		str.contains(UpdatePackageType.yabai.str()) {
			.yabai
		}
		else {
			.normal
		}
	}
}

fn parse_answer(str string) Answer {
	return match str {
		'Yes', 'Y' {
			.yes
		}
		'no', 'n' {
			.no
		}
		else {
			.others
		}
	}
}

fn (c Command) execute_update() ! {
	if c.name == 'brew' {
		c.exec_with_print('upgrade', .with_print)!
	} else {
		return error(response_err('Specified command should be `brew`'))
	}
}

fn not_execute_update() ! {
	return error(response_err('`brew upgrade` is not executed. Please try again.'))
}

fn (c Command) update_all(list []UpdatePackageType) ! {
	if list.contains(.yabai) {
		for {
			answer := parse_answer(os.input(response_warn('yabai is outdated. Update all including it? (Y/n) : ')))
			match answer {
				.yes {
					yabai := create_command('yabai')!
					yabai.exec_with_print('--stop-service', .with_print)!
					c.execute_update()!
					break
				}
				.no {
					not_execute_update()!
					break
				}
				.others {
					println(response_warn('Please choise Y or n'))
					println('')
					continue
				}
			}
		}
	} else {
		c.execute_update()!
	}
}
