module mycmd

import cli

pub const flags = {
	'output': cli.Flag{
		flag: cli.FlagType.bool
		name: 'output'
		abbrev: 'd'
		description: 'Prints the result only (not write to the file)'
	}
}
