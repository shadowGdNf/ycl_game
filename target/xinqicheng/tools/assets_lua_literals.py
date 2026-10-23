#!/usr/bin/env python3
"""Strict, non-executing parser for data-only Lua return tables.

Accepts only tables, scalar literals and literal field names. Expressions,
function calls, operators, metatables, and statements other than initial return
are rejected. Used for source atlas/animation data, never as a Lua interpreter.
"""
from __future__ import annotations
import ast
import json
import re
import sys
from pathlib import Path

TOKEN = re.compile(r'''\s+|--[^\n]*|(?P<string>'(?:[^'\\]|\\.)*'|"(?:[^"\\]|\\.)*")|(?P<number>-?(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?)|(?P<identifier>[A-Za-z_][A-Za-z_0-9]*)|(?P<punct>[{}\[\],;=])''')


class Parser:
    def __init__(self, source: str):
        self.tokens = []
        cursor = 0
        for match in TOKEN.finditer(source):
            if match.start() != cursor:
                raise ValueError(f"Unsupported Lua syntax at character {cursor}")
            cursor = match.end()
            if match.lastgroup:
                self.tokens.append((match.lastgroup, match.group()))
        if cursor != len(source):
            raise ValueError(f"Unsupported Lua syntax at character {cursor}")
        self.i = 0

    def peek(self, step=0):
        return self.tokens[self.i + step][1] if self.i + step < len(self.tokens) else None

    def take(self, expected=None):
        if self.i >= len(self.tokens):
            raise ValueError("Unexpected end of literal")
        kind, value = self.tokens[self.i]
        self.i += 1
        if expected is not None and value != expected:
            raise ValueError(f"Expected {expected!r}, got {value!r}")
        return kind, value

    def value(self):
        if self.peek() == "{":
            return self.table()
        kind, value = self.take()
        if kind == "number":
            return float(value) if any(c in value for c in ".eE") else int(value)
        if kind == "string":
            return ast.literal_eval(value)
        if kind == "identifier" and value in ("true", "false", "nil"):
            return {"true": True, "false": False, "nil": None}[value]
        raise ValueError(f"Expected scalar literal, got {value!r}")

    def table(self):
        self.take("{")
        sequence, mapping = [], {}
        while self.peek() != "}":
            if self.peek() is None:
                raise ValueError("Unterminated table")
            if self.peek() == "[":
                self.take("[")
                key = self.value()
                self.take("]")
                self.take("=")
                mapping[key] = self.value()
            elif self.peek(1) == "=":
                kind, key = self.take()
                if kind != "identifier":
                    raise ValueError("Only literal identifiers are valid field names")
                self.take("=")
                mapping[key] = self.value()
            else:
                sequence.append(self.value())
            if self.peek() in (",", ";"):
                self.take()
            elif self.peek() != "}":
                raise ValueError("Missing table separator")
        self.take("}")
        if mapping and sequence:
            for index, value in enumerate(sequence, 1):
                if index in mapping:
                    raise ValueError("Duplicate table key")
                mapping[index] = value
        return mapping if mapping else sequence

    def parse(self):
        self.take("return")
        result = self.value()
        if self.i != len(self.tokens):
            raise ValueError("Data after return table")
        return result


def parse(source: str):
    return Parser(source).parse()


if __name__ == "__main__":
    path = Path(sys.argv[1])
    data = parse(path.read_text())
    json.dump(data, sys.stdout, ensure_ascii=False, separators=(",", ":"))
    print()
