c = get_config()

c.IPKernelApp.matplotlib = 'inline'

c.InteractiveShellApp.exec_lines = []
c.InteractiveShellApp.exec_lines.append('%load_ext autoreload')
c.InteractiveShellApp.exec_lines.append('%autoreload 2')
# c.InteractiveShellApp.exec_lines.append('%config Completer.use_jedi = False')
# %config Completer.use_jedi = True
c.IPCompleter.use_jedi = False
