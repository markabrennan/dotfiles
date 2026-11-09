"""Interactive Python startup: vi editing mode (needs PYTHON_BASIC_REPL=1 on 3.13+)."""

try:
    import readline
except ImportError:
    pass
else:
    if getattr(readline, "backend", None) == "editline" or "libedit" in (readline.__doc__ or ""):
        readline.parse_and_bind("bind -v")
    else:
        readline.parse_and_bind("set editing-mode vi")
    del readline
