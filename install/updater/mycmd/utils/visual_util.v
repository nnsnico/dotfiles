module utils

import term

pub fn response_progress(message string) string {
	return term.green('===> ${message} ...')
}

pub fn response_ok(message string) string {
	return term.green('===> ${message}')
}

pub fn response_err(message string) string {
	return term.red('===> ${message}')
}

pub fn response_warn(message string) string {
	return term.yellow('===> ${message}')
}

fn response_message(message string) string {
	return '===> ${message} ...'
}
