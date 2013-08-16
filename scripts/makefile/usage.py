#!/usr/bin/env python
from os import environ as e
import textwrap

def main():

    width = 90
    target_help = [ 
        ( 'doc', """
            build the documentation for haplorec in documentation/
        """ ),
    ]

    help_wrapper = textwrap.TextWrapper(width=width, initial_indent="    ", subsequent_indent="    ")
    print 'Useful targets:\n'
    for target, help in target_help:
        print target + ':'
        print help_wrapper.fill(textwrap.dedent(help).replace('\n', '')), '\n'

if __name__ == '__main__':
    main()
