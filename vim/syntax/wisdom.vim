syn match     wisdomOperator          "[()+.,\-/*=&]"
syn match     wisdomOperator          "[<>]=\="
syn match     wisdomOperator          "<>"
syn match     wisdomOperator          "\s\+_$"

syn match     wisdomOperator            "[:%!$?~]"
syn match     wisdomOperator            "(\||\|\>)"
syn match     wisdomOperator            "\-\>"

syn keyword   wisdomStatement	        goto asm
syn keyword   wisdomLabel		        case default

syn keyword	  wisdomStructure	        struct union enum typedef

syn region	  wisdomIncluded	        display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	  wisdomIncluded	        display contained "<[^>]*>"
syn match	  wisdomInclude	            display "^\s*\zs\(%:\|#\)\s*include\>\s*["<]" contains=wisdomIncluded

syn keyword	  wisdomStorageClass	    static register volatile extern
syn keyword	  wisdomStorageClass	    inline __attribute__

" syn region    wisdomComment	        matchgroup=wisdomCommentStart start="/\*" end="\*/" contains=@wisdomCommentGroup,wisdomCommentStartError,wisdomCommentString,wisdomCharacter,wisdomNumbersCom,wisdomSpaceError,@Spell extend
" syn region	wisdomCommentL	        start="//" skip="\\$" end="$" keepend contains=@wisdomCommentGroup,wisdomSpaceError,@Spell
" syn region    wisdomCommentL	        start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError,cWrongComTail,@Spell

syn keyword wisdomType                void bool Object
syn keyword wisdomStructure	        table dataframe matrix
syn keyword wisdomStatement	        this self
syn keyword wisdomStatement	        go run call
syn keyword wisdomStatement	        nogc dynamic
syn keyword wisdomStatement	        override safe unsafe
syn keyword wisdomStatement	        private protected public
syn keyword wisdomStatement	        error option ok some none
syn keyword wisdomStatement	        lazy eager
syn keyword wisdomStatement	        heap memory allocate free
syn keyword wisdomStatement	        begin end
syn keyword wisdomStatement	        typeof sizeof addressof ptr to deref block
syn keyword wisdomRepeat	            do loop wend foreach next step until
syn keyword wisdomException	        catch throw
syn keyword wisdomOperator	        xor like mod
syn keyword wisdomStatement	        program proc procedure sub subroutine fn func function interface alias type new unittest nextgroup=wisdomFunction skipwhite
syn keyword wisdomStatement	        echo printf fprintf
syn keyword wisdomStatement	        let var const
syn keyword wisdomStatement	        false null true
syn keyword wisdomStatement	        discard standart only export defer

syn keyword wisdomConditional	        elif else if
" syn keyword wisdomStatement	        False None True
syn keyword wisdomStatement	        as assert break continue del exec global
syn keyword wisdomStatement	        lambda nonlocal pass print return with yield
syn keyword wisdomStatement	        class def nextgroup=wisdomFunction skipwhite
syn keyword wisdomRepeat	            for while
syn keyword wisdomOperator	        and in is not or
syn keyword wisdomException	        except finally raise try
syn keyword wisdomInclude	            from import
syn keyword wisdomAsync		        async await

syn match   wisdomFunction	        "\h\w*" display contained
syn match   wisdomDecorator	        "@" display contained
syn match   wisdomDecoratorName	    "@\s*\h\%(\w\|\.\)*" display contains=wisdomDecorator

syn match   wisdomNumber	            "\<0[oO]\=\o\+[Ll]\=\>"
syn match   wisdomNumber	            "\<0[xX]\x\+[Ll]\=\>"
syn match   wisdomNumber	            "\<0[bB][01]\+[Ll]\=\>"
syn match   wisdomNumber	            "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   wisdomNumber	            "\<\d\+[jJ]\>"
syn match   wisdomNumber	            "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   wisdomNumber              "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   wisdomNumber              "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

syn keyword wisdomTypes               boolean byte currency date decimal double
syn keyword wisdomTypes               integer long object single string variant
syn keyword wisdomTypes               int str auto float char signed unsigned short

" built-in functions
" syn keyword wisdomBuiltin	False True None
syn keyword wisdomBuiltin	            NotImplemented Ellipsis __debug__
" syn keyword wisdomBuiltin	            abs all any bin bool bytearray callable chr
syn keyword wisdomBuiltin	            abs all any bin bytearray callable chr
syn keyword wisdomBuiltin	            classmethod compile complex delattr dict dir
syn keyword wisdomBuiltin	            divmod enumerate eval filter format
" syn keyword wisdomBuiltin	            divmod enumerate eval filter float format
syn keyword wisdomBuiltin	            frozenset getattr globals hasattr hash
" syn keyword wisdomBuiltin	            help hex id input int isinstance
syn keyword wisdomBuiltin	            help hex id input isinstance
syn keyword wisdomBuiltin	            issubclass iter len list locals map max
syn keyword wisdomBuiltin	            memoryview min next object oct open ord pow
syn keyword wisdomBuiltin	            print property range repr reversed round set
syn keyword wisdomBuiltin	            setattr slice sorted staticmethod
" syn keyword wisdomBuiltin	            setattr slice sorted staticmethod str
syn keyword wisdomBuiltin	            sum super tuple vars zip __import__
" syn keyword wisdomBuiltin	            sum super tuple type vars zip __import__
syn keyword wisdomBuiltin	            basestring cmp execfile file
syn keyword wisdomBuiltin	            long raw_input reduce reload unichr
syn keyword wisdomBuiltin	            unicode xrange
syn keyword wisdomBuiltin	            ascii bytes exec
syn keyword wisdomBuiltin	            apply buffer coerce intern

syn keyword wisdomExceptions	        BaseException Exception
syn keyword wisdomExceptions	        ArithmeticError BufferError
syn keyword wisdomExceptions	        LookupError
syn keyword wisdomExceptions	        EnvironmentError StandardError
syn keyword wisdomExceptions	        AssertionError AttributeError
syn keyword wisdomExceptions	        EOFError FloatingPointError GeneratorExit
syn keyword wisdomExceptions	        ImportError IndentationError
syn keyword wisdomExceptions	        IndexError KeyError KeyboardInterrupt
syn keyword wisdomExceptions	        MemoryError NameError NotImplementedError
syn keyword wisdomExceptions	        OSError OverflowError ReferenceError
syn keyword wisdomExceptions	        RuntimeError StopIteration SyntaxError
syn keyword wisdomExceptions	        SystemError SystemExit TabError TypeError
syn keyword wisdomExceptions	        UnboundLocalError UnicodeError
syn keyword wisdomExceptions	        UnicodeDecodeError UnicodeEncodeError
syn keyword wisdomExceptions	        UnicodeTranslateError ValueError
syn keyword wisdomExceptions	        ZeroDivisionError
syn keyword wisdomExceptions	        BlockingIOError BrokenPipeError
syn keyword wisdomExceptions	        ChildProcessError ConnectionAbortedError
syn keyword wisdomExceptions	        ConnectionError ConnectionRefusedError
syn keyword wisdomExceptions	        ConnectionResetError FileExistsError
syn keyword wisdomExceptions	        FileNotFoundError InterruptedError
syn keyword wisdomExceptions	        IsADirectoryError NotADirectoryError
syn keyword wisdomExceptions	        PermissionError ProcessLookupError
syn keyword wisdomExceptions	        RecursionError StopAsyncIteration
syn keyword wisdomExceptions	        TimeoutError
syn keyword wisdomExceptions	        IOError VMSError WindowsError
syn keyword wisdomExceptions	        BytesWarning DeprecationWarning FutureWarning
syn keyword wisdomExceptions	        ImportWarning PendingDeprecationWarning
syn keyword wisdomExceptions	        RuntimeWarning SyntaxWarning UnicodeWarning
syn keyword wisdomExceptions	        UserWarning Warning
syn keyword wisdomExceptions	        ResourceWarning

syn region wisdomDoctest              start="^\s*>>>\s" end="^\s*$" contained contains=ALLBUT,wisdomDoctest,wisdomFunction,@Spell
syn region wisdomDoctestValue         start=+^\s*\%(>>>\s\|\.\.\.\s\|"""\|'''\)\@!\S\++ end="$" contained

syn sync match wisdomSync grouphere NONE "^\%(def\|class\|interface\|abstract\|type\|fn\|func\|function\|sub\|subroutine\|prog\|program\)\s\+\h\w*\s*[(:]"

syn match   wisdomAttribute	/\.\h\w*/hs=s+1
  \ contains=ALLBUT,wisdomBuiltin,wisdomFunction,wisdomAsync
  \ transparent

syn region  wisdomString matchgroup=wisdomQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=wisdomEscape,@Spell
syn region  wisdomString matchgroup=wisdomTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=wisdomEscape,wisdomSpaceError,wisdomDoctest,@Spell
syn region  wisdomRawString matchgroup=wisdomQuotes
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell
syn region  wisdomRawString matchgroup=wisdomTripleQuotes
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
      \ contains=wisdomSpaceError,wisdomDoctest,@Spell

" *** C Like syntax groups ***
syn match	      cSpecial	          display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
" ----------------------------------------------

" *** C Todo and bad continuation ***
syn keyword	  cTodo		          contained TODO FIXME XXX
syn match	      cBadContinuation    contained "\\\s\+$"
" ----------------------------------------------

" *** C Comment String ***
syn region      cCommentString	  contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
syn region      cComment2String	  contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
" ----------------------------------------------

" *** C Comment Group ***
syn cluster	  cCommentGroup	      contains=cTodo,cBadContinuation
syn match	      cCommentStartError  display "/\*"me=e-1 contained
" ----------------------------------------------

" *** C Numbers ***
syn match	      cOctal		      display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=cOctalZero
syn match	      cOctalZero	      display contained "\<0"

syn match	      cFloat		      display contained "\d\+f"
syn match	      cFloat		      display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
syn match	      cFloat		      display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match	      cFloat		      display contained "\d\+e[-+]\=\d\+[fl]\=\>"

syn match	      cNumber		      display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match	      cNumber		      display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"

syn match	      cNumbers	          display transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctal
syn match	      cNumbersCom	      display contained transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctal
" ----------------------------------------------

" *** C Trailing Space Errors ***
if exists("c_space_errors")
  if !exists("c_no_trail_space_error")
    syn match	cSpaceError	display excludenl "\s\+$"
  endif
  if !exists("c_no_tab_space_error")
    syn match	cSpaceError	display " \+\t"me=e-1
  endif
endif

syn match	    cWrongComTail	        display "\*/"
" ----------------------------------------------

" *** C Preprocessor Conditionals***
syn region	cPreCondit	            start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=cComment,cCommentL,cCharacter,cNumbers,cCommentError,cSpaceError
syn match	    cPreConditMatch	        display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"
" ----------------------------------------------

" *** C Define Preprocessor Keywords ***
syn cluster	wisdomPreProcGroup	    contains=wisdomIncluded,wisdomInclude,wisdomDefine,cSpecial,cOctalZero,wisdomFormat,cNumber,cFloat,cOctal,cNumbersCom,cString,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError
syn region    wisdomDefine		    start="^\s*\zs\(%:\|#\)\s*\(define\|undef\|preprocess\|macro\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@wisdomPreProcGroup,@Spell
syn region    wisdomDefine		    start="^\s*\zs\(%:\|#\)\s*\(f\|p\|s\)\>" skip="\\$" end="\s"
" ----------------------------------------------

" *** C Style Commenting ***
syn region      cCommentL	            start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError,cWrongComTail,@Spell
syn region      cComment	            matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError,@Spell extend
" ----------------------------------------------

" *** C dur bi ***
syn match	    wisdomFormat		    display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlLjzt]\|ll\|hh\)\=\([aAbdiuoxXDOUfFeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
" syn match	    wisdomFormat		    display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
syn match	    wisdomFormat		    display "%%" contained

" syn region    wisdomPreCondit	    start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\|s\|f\|p\)\>" skip="\\$" end="$" keepend contains=wisdomComment,wisdomCommentL,wisdomString,wisdomCharacter,wisdomParen,wisdomParenError,wisdomNumbers,wisdomCommentError,wisdomSpaceError
" syn region    wisdomPreCondit	    start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=wisdomComment,wisdomString,wisdomSpaceError
" syn match	  wisdomPreConditMatch	display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"

" syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cErrInParen,cErrInBracket,cUserLabel,cSpecial,cOctalZero,cCppOutWrapper,cCppInWrapper,@cCppOutInGroup,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cString,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cParen,cBracket,cMulti,cBadBlock
" syn region	cDefine		start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
" syn region	cPreProc	start="^\s*\zs\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
" ----------------------------------------------

" *** C Labels ***
" Highlight User Labels
" syn cluster	cMultiGroup	contains=cIncluded,cSpecial,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cUserCont,cUserLabel,cBitField,cOctalZero,cCppOutWrapper,cCppInWrapper,@cCppOutInGroup,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cCppParen,cCppBracket,cCppString
syn cluster	  cMultiGroup	        contains=wisdomIncluded,cSpecial,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cUserCont,cUserLabel,cBitField,cOctalZero,cCppOutWrapper,cCppInWrapper,@cCppOutInGroup,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cCppParen,cCppBracket,cCppString
syn region	  cMulti		        transparent start='?' skip='::' end=':' contains=ALLBUT,@cMultiGroup,@Spell,@cStringGroup
syn cluster	  cLabelGroup	        contains=cUserLabel

syn match	      cUserCont	            display "^\s*\zs\I\i*\s*:$" contains=@cLabelGroup
syn match	      cUserCont	            display ";\s*\zs\I\i*\s*:$" contains=@cLabelGroup

" syn match	      cUserCont	            display "^\s*\zs\%(class\|struct\|enum\)\@!\I\i*\s*:[^:]"me=e-1 contains=@cLabelGroup
" syn match	      cUserCont	            display ";\s*\zs\%(class\|struct\|enum\)\@!\I\i*\s*:[^:]"me=e-1 contains=@cLabelGroup

syn match	      cUserCont	            display "^\s*\zs\I\i*\s*:[^:]"me=e-1 contains=@cLabelGroup
syn match	      cUserCont	            display ";\s*\zs\I\i*\s*:[^:]"me=e-1 contains=@cLabelGroup

syn match	      cBitField	            display "^\s*\zs\I\i*\s*:\s*[1-9]"me=e-1 contains=cType
syn match	      cBitField	            display ";\s*\zs\I\i*\s*:\s*[1-9]"me=e-1 contains=cType

syn match	      cUserLabel	        display "\I\i*" contained

" Highlight all function names
syntax match    cCustomFunc           /\w\+\s*(/me=e-1,he=e-1
" ----------------------------------------------

" *** C String formatting ***
syn region	  cString		        start=+\%(L\|U\|u8\)\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,cFormat,@Spell extend

syn match	      cFormat		        display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlLjzt]\|ll\|hh\)\=\([aAbdiuoxXDOUfFeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
" syn match	      cFormat		        display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
syn match	      cFormat		        display "%%" contained
" ----------------------------------------------

hi def link     cUserLabel		    Label
hi def link     cCustomFunc           Function

hi def link     cTodo		            Todo
hi def link     cBadContinuation	    Error

hi def link     cComment2String	    cString
hi def link     cString		        String
hi def link     cCharacter		    Character

hi def link     cSpaceError		    cError
hi def link     cWrongComTail	        cError
hi def link     cError		        Error

hi def link     cCommentL		        cComment
hi def link     cCommentStart	        cComment

hi def link     cCommentSkip	        cComment
hi def link     cComment		        Comment

hi def link     cNumber		        Number
hi def link     cOctal		        Number
hi def link     cOctalZero		    PreProc	 " link this to Error if you want
hi def link     cFloat		        Float

hi def link     cFormat		        cSpecial
hi def link     cSpecial		        SpecialChar
" ----------------------------------------------

hi def link     wisdomLabel		    Label
hi def link     wisdomFormat		    wisdomSpecial

hi def link     wisdomSpecial		    SpecialChar
hi def link     wisdomDefine		    Macro

" hi def link   wisdomPreProc		    PreProc

hi def link     wisdomStructure		Structure
hi def link     wisdomIncluded		wisdomString
hi def link     wisdomStorageClass	StorageClass

hi def link     wisdomConditional		Conditional
hi def link     wisdomStatement		Statement
hi def link     wisdomRepeat		    Repeat
hi def link     wisdomOperator		Operator
hi def link     wisdomException		Exception
hi def link     wisdomInclude		    Include
hi def link     wisdomAsync			Statement
hi def link     wisdomDecorator		Define
hi def link     wisdomDecoratorName	Function
hi def link     wisdomFunction		Function
" hi def lin    k wisdomComment		    Comment
" hi def lin    k wisdomCommentL		Comment
hi def link     wisdomTodo			Todo
hi def link     wisdomString		    String
hi def link     wisdomRawString		String
hi def link     wisdomQuotes		    String
hi def link     wisdomTripleQuotes	wisdomQuotes
hi def link     wisdomEscape		    Special
hi def link     wisdomNumber		    Number
hi def link     wisdomBuiltin		    Function
hi def link     wisdomExceptions		Structure
hi def link     wisdomSpaceError		Error
hi def link     wisdomDoctest		    Special
hi def link     wisdomDoctestValue	Define
hi def link     wisdomTypes			Type
hi def link     wisdomType			Type

