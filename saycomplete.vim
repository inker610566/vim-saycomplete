func! s:Say(what)
    call system('say "'.a:what.'" -v Vicki')
endf

func! s:Run()
    func! g:NoOmnifunc(findstart, base)
        if a:findstart
            return col('.')
        else
            call s:Say('no available omnifunc found')
        endif
    endf

    func! g:SayOmnifunc(findstart, base)
        let res = call(s:TrueOmnifunc, [a:findstart, a:base])
        if a:findstart == 0
            "call s:Say(printf('%d matches', len(res)))
            if len(res) == 1
                call s:Say(s:CItem2Word(res[0]))
            end
        endif
        return res
    endf

    func s:CItem2Word(citem)
        if type(a:citem) == type({})
            return a:citem['word']
        else
            return a:citem
        endif
    endf

    let s:TrueOmnifunc = &omnifunc
    if len(s:TrueOmnifunc) == 0
        set omnifunc=g:NoOmnifunc
    else
        set omnifunc=g:SayOmnifunc
    endif
endf

call s:Run()
