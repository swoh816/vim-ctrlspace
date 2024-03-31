let s:config       = ctrlspace#context#Configuration()
let s:modes        = ctrlspace#modes#Modes()
let s:commonMap    = {}
let s:helpMap      = {}
let s:lastListView = "Buffer"

function! ctrlspace#keys#common#Init() abort
    call s:map("ToggleHelp",                   "?")
    call s:map("Down",                         "j")
    call s:map("Up",                           "k")
    call s:map("Previous",                     "p")
    call s:map("PreviousCR",                   "P")
    call s:map("Next",                         "n")
    call s:map("MouseDown",                    "MouseDown")
    call s:map("MouseUp",                      "MouseUp")
    call s:map("LeftRelease",                  "LeftRelease")
    call s:map("LeftMouse2",                   '2-LeftMouse')
    call s:map("DownArrow",                    "Down")
    call s:map("UpArrow",                      "Up")
    call s:map("Home",                         "Home")
    call s:map("Top",                          "K")
    call s:map("End",                          "End")
    call s:map("Bottom",                       "J")
    call s:map("PageDown",                     "PageDown")
    call s:map("ScrollDown",                   'C-f')
    call s:map("PageUp",                       "PageUp")
    call s:map("ScrollUp",                     'C-b')
    call s:map("HalfScrollDown",               'C-d')
    call s:map("HalfScrollUp",                 'C-u')
    call s:map("Close",                        "q", "Esc", 'C-c')
    call s:map("Quit",                         "Q")
    call s:map("EnterSearchMode",              "/")
    call s:map("RestorePreviousSearch",        'C-p')
    call s:map("RestoreNextSearch",            'C-n')
    call s:map("BackOrClearSearch",            "BS")
    call s:map("ToggleFileMode",               "o")
    call s:map("ToggleFileModeAndSearch",      "O")
    call s:map("ToggleBufferMode",             "h")
    call s:map("ToggleBufferModeAndSearch",    "H")
    call s:map("ToggleWorkspaceMode",          "w")
    call s:map("ToggleWorkspaceModeAndSearch", "W")
    call s:map("ToggleTabMode",                "l")
    call s:map("ToggleTabModeAndSearch",       "L")
    call s:map("ToggleBookmarkMode",           "b")
    call s:map("ToggleBookmarkModeAndSearch",  "B")

    call s:map("CountPrefix2",                 "2")

    let keyMap  = ctrlspace#keys#KeyMap()
    let helpMap = ctrlspace#help#HelpMap()

    for m in ["Buffer", "File", "Tab", "Workspace", "Bookmark"]
        call extend(keyMap[m], s:commonMap)
        call extend(helpMap[m], s:helpMap)
    endfor
endfunction

function! s:map(func, ...) abort
    let fn = "ctrlspace#keys#common#" . a:func
    let Ref = function(fn)

    for k in a:000
        let s:helpMap[k] = fn
        let s:commonMap[k] = Ref
    endfor
endfunction

function! ctrlspace#keys#common#EnterSearchMode(k) abort
    call ctrlspace#search#SwitchSearchMode(1)
endfunction

function! ctrlspace#keys#common#RestorePreviousSearch(k) abort
    call ctrlspace#search#RestoreSearchLetters("previous")
endfunction

function! ctrlspace#keys#common#RestoreNextSearch(k) abort
    call ctrlspace#search#RestoreSearchLetters("next")
endfunction

function! ctrlspace#keys#common#ToggleHelp(k) abort
    call ctrlspace#window#Kill(0, 0)

    if s:modes.Help.Enabled
        call s:modes.Help.Disable()
    else
        call s:modes.Help.Enable()
    endif

    call ctrlspace#window#Toggle(1)
endfunction

function! ctrlspace#keys#common#Up(k) abort
    call ctrlspace#window#MoveSelectionBar("up")
endfunction

function! ctrlspace#keys#common#Down(k) abort
    call ctrlspace#window#MoveSelectionBar("down")
endfunction

function! ctrlspace#keys#common#Previous(k) abort
    call ctrlspace#jumps#Jump("previous")
endfunction

function! ctrlspace#keys#common#PreviousCR(k) abort
    call ctrlspace#jumps#Jump("previous")
    call feedkeys("\<CR>")
endfunction

function! ctrlspace#keys#common#Next(k) abort
    call ctrlspace#jumps#Jump("next")
endfunction

function! ctrlspace#keys#common#MouseUp(k) abort
    if s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("down")
    endif
endfunction

function! ctrlspace#keys#common#MouseDown(k) abort
    if s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("up")
    endif
endfunction

function! ctrlspace#keys#common#LeftRelease(k) abort
    if s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("mouse")
    endif
endfunction

function! ctrlspace#keys#common#LeftMouse2(k) abort
    if s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("mouse")
        call feedkeys("\<CR>")
    endif
endfunction

function! ctrlspace#keys#common#DownArrow(k) abort
    if s:config.UseArrowsInTerm || s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("down")
    endif
endfunction

function! ctrlspace#keys#common#UpArrow(k) abort
    if s:config.UseArrowsInTerm || s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("up")
    endif
endfunction

function! ctrlspace#keys#common#Home(k) abort
    if s:config.UseArrowsInTerm || s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar(1)
    endif
endfunction

function! ctrlspace#keys#common#Top(k) abort
    call ctrlspace#window#MoveSelectionBar(1)
endfunction

function! ctrlspace#keys#common#End(k) abort
    if s:config.UseArrowsInTerm || s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar(line("$"))
    endif
endfunction

function! ctrlspace#keys#common#Bottom(k) abort
    call ctrlspace#window#MoveSelectionBar(line("$"))
endfunction

function! ctrlspace#keys#common#PageDown(k) abort
    if s:config.UseArrowsInTerm || s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("pgdown")
    endif
endfunction

function! ctrlspace#keys#common#ScrollDown(k) abort
    call ctrlspace#window#MoveSelectionBar("pgdown")
endfunction

function! ctrlspace#keys#common#PageUp(k) abort
    if s:config.UseArrowsInTerm || s:config.UseMouseAndArrowsInTerm || has("gui_running")
        call ctrlspace#window#MoveSelectionBar("pgup")
    endif
endfunction

function! ctrlspace#keys#common#ScrollUp(k) abort
    call ctrlspace#window#MoveSelectionBar("pgup")
endfunction

function! ctrlspace#keys#common#HalfScrollDown(k) abort
    call ctrlspace#window#MoveSelectionBar("half_pgdown")
endfunction

function! ctrlspace#keys#common#HalfScrollUp(k) abort
    call ctrlspace#window#MoveSelectionBar("half_pgup")
endfunction

function! ctrlspace#keys#common#Close(k) abort
    call ctrlspace#window#Kill(0, 1)
endfunction

function! ctrlspace#keys#common#Quit(k) abort
    call ctrlspace#window#QuitVim()
endfunction

function! s:toggleListViewAndSearch(k, mode) abort
    if !s:modes[a:mode].Enabled
        if !function("ctrlspace#keys#common#Toggle" . a:mode . "Mode")(a:k)
            return 0
        endif
    endif

    call ctrlspace#search#SwitchSearchMode(1)
    return 1
endfunction

function! s:toggleListView(k, mode) abort
    " TODO Temporary place
    if s:modes.Workspace.Enabled
        call s:modes.Workspace.SetData("LastBrowsed", line("."))
    endif

    if s:modes[a:mode].Enabled
        if s:lastListView ==# a:mode
            return 0
        else
            return function("ctrlspace#keys#common#Toggle" . s:lastListView . "Mode")(a:k)
        endif
    endif

    let s:lastListView = ctrlspace#modes#CurrentListView().Name

    call ctrlspace#window#Kill(0, 0)
    call s:modes[a:mode].Enable()
    call ctrlspace#window#Toggle(1)

    return 1
endfunction

function! ctrlspace#keys#common#BackOrClearSearch(k) abort
    if !empty(s:modes.Search.Data.Letters)
        call ctrlspace#search#ClearSearchMode()
    elseif !empty(s:lastListView)
        if ctrlspace#modes#CurrentListView().Name ==# s:lastListView
            return 0
        else
            return function("ctrlspace#keys#common#Toggle" . s:lastListView . "Mode")(a:k)
        endif
    endif
endfunction

function! ctrlspace#keys#common#ToggleFileModeAndSearch(k) abort
    return s:toggleListViewAndSearch(a:k, "File")
endfunction

function! ctrlspace#keys#common#ToggleFileMode(k) abort
    if !ctrlspace#roots#ProjectRootFound()
        return 0
    endif

    return s:toggleListView(a:k, "File")
endfunction

function! ctrlspace#keys#common#ToggleBufferModeAndSearch(k) abort
    return s:toggleListViewAndSearch(a:k, "Buffer")
endfunction

function! ctrlspace#keys#common#ToggleBufferMode(k) abort
    return s:toggleListView(a:k, "Buffer")
endfunction

function! ctrlspace#keys#common#ToggleWorkspaceModeAndSearch(k) abort
    return s:toggleListViewAndSearch(a:k, "Workspace")
endfunction

function! ctrlspace#keys#common#ToggleWorkspaceMode(k) abort
    if empty(ctrlspace#workspaces#Workspaces())
        return s:saveFirstWorkspace()
    else
        return s:toggleListView(a:k, "Workspace")
    endif
endfunction

function! ctrlspace#keys#common#ToggleTabModeAndSearch(k) abort
    return s:toggleListViewAndSearch(a:k, "Tab")
endfunction

function! ctrlspace#keys#common#ToggleTabMode(k) abort
    return s:toggleListView(a:k, "Tab")
endfunction

function! ctrlspace#keys#common#ToggleBookmarkModeAndSearch(k) abort
    return s:toggleListViewAndSearch(a:k, "Bookmark")
endfunction

function! ctrlspace#keys#common#CountPrefix2(k) abort
  let count = 0
  let key = input('Press key:' )
  while count < 2
    if key == "k"
      call ctrlspace#window#MoveSelectionBar("up")
    elseif key == "j"
      call ctrlspace#window#MoveSelectionBar("down")
    endif
    let count += 1
  endwhile
  return 1
endfunction

function! ctrlspace#keys#common#ToggleBookmarkMode(k) abort
    if empty(ctrlspace#bookmarks#Bookmarks())
        call ctrlspace#bookmarks#AddFirstBookmark()
        return 0
    else
        return s:toggleListView(a:k, "Bookmark")
    endif
endfunction

function! s:saveFirstWorkspace() abort
    let labels = []

    for t in range(1, tabpagenr("$"))
        let label = ctrlspace#util#Gettabvar(t, "CtrlSpaceLabel")
        if !empty(label)
            call add(labels, label)
        endif
    endfor

    let name = ctrlspace#ui#GetInput("Save first workspace as: ", join(labels, " "))

    if empty(name)
        return 0
    endif

    let lv = ctrlspace#modes#CurrentListView()

    call ctrlspace#window#Kill(0, 1)

    let ok = ctrlspace#workspaces#SaveWorkspace(name)

    call ctrlspace#window#Toggle(0)

    if ok
        let lv = s:modes.Workspace
    elseif lv.Name ==# "Buffer"
        return 0
    endif

    call ctrlspace#window#Kill(0, 0)
    call lv.Enable()
    call ctrlspace#window#Toggle(1)
    call ctrlspace#ui#DelayedMsg()

    return ok
endfunction
