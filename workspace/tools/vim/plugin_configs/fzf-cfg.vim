" https://github.com/junegunn/fzf.vim
" Commands
" --------
" 
" | Command                | List                                                                                  |
" | ---                    | ---                                                                                   |
" | `:Files [PATH]`        | Files (runs `$FZF_DEFAULT_COMMAND` if defined)                                        |
" | `:GFiles [OPTS]`       | Git files (`git ls-files`)                                                            |
" | `:GFiles?`             | Git files (`git status`)                                                              |
" | `:Buffers`             | Open buffers                                                                          |
" | `:Colors`              | Color schemes                                                                         |
" | `:Ag [PATTERN]`        | [ag][ag] search result (`ALT-A` to select all, `ALT-D` to deselect all)               |
" | `:Rg [PATTERN]`        | [rg][rg] search result (`ALT-A` to select all, `ALT-D` to deselect all)               |
" | `:Lines [QUERY]`       | Lines in loaded buffers                                                               |
" | `:BLines [QUERY]`      | Lines in the current buffer                                                           |
" | `:Tags [QUERY]`        | Tags in the project (`ctags -R`)                                                      |
" | `:BTags [QUERY]`       | Tags in the current buffer                                                            |
" | `:Marks`               | Marks                                                                                 |
" | `:Windows`             | Windows                                                                               |
" | `:Locate PATTERN`      | `locate` command output                                                               |
" | `:History`             | `v:oldfiles` and open buffers                                                         |
" | `:History:`            | Command history                                                                       |
" | `:History/`            | Search history                                                                        |
" | `:Snippets`            | Snippets ([UltiSnips][us])                                                            |
" | `:Commits [LOG_OPTS]`  | Git commits (requires [fugitive.vim][f])                                              |
" | `:BCommits [LOG_OPTS]` | Git commits for the current buffer; visual-select lines to track changes in the range |
" | `:Commands`            | Commands                                                                              |
" | `:Maps`                | Normal mode mappings                                                                  |
" | `:Helptags`            | Help tags <sup id="a1">[1](#helptags)</sup>                                           |
" | `:Filetypes`           | File types
"
