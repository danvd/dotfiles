(c-add-style "ft_style"
	     '("gnu"
	       (c-basic-offset . 4)	; Guessed value
	       (c-offsets-alist
		(access-label . 0)	; Guessed value
		(arglist-cont . 0)	; Guessed value
		(arglist-intro . +)	; Guessed value
		(block-close . 0)	; Guessed value
		(brace-entry-open . 0)	; Guessed value
		(class-close . 0)	; Guessed value
		(defun-block-intro . +)	; Guessed value
		(defun-close . 0)	; Guessed value
		(inclass . +)		; Guessed value
		(inline-close . 0)	; Guessed value
		(member-init-cont . -)	; Guessed value
		(member-init-intro . +)	; Guessed value
		(statement . 0)		; Guessed value
		(statement-block-intro . +) ; Guessed value
		(statement-cont . +)	; Guessed value
		(substatement . +)	; Guessed value
		(topmost-intro . 0)	; Guessed value
		(topmost-intro-cont . 0) ; Guessed value
		(annotation-top-cont . 0)
		(annotation-var-cont . +)
		(arglist-close . c-lineup-close-paren)
		(arglist-cont-nonempty . c-lineup-arglist)
		(block-open . 0)
		(brace-list-close . 0)
		(brace-list-entry . c-lineup-under-anchor)
		(brace-list-intro . +)
		(brace-list-open . 0)
		(c . c-lineup-C-comments)
		(case-label . 0)
		(catch-clause . 0)
		(class-open . 0)
		(comment-intro . c-lineup-comment)
		(composition-close . 0)
		(composition-open . 0)
		(cpp-define-intro c-lineup-cpp-define +)
		(cpp-macro . -1000)
		(cpp-macro-cont . +)
		(defun-open . 0)
		(do-while-closure . 0)
		(else-clause . 0)
		(extern-lang-close . 0)
		(extern-lang-open . 0)
		(friend . 0)
		(func-decl-cont . +)
		(incomposition . +)
		(inexpr-class . +)
		(inexpr-statement . +)
		(inextern-lang . +)
		(inher-cont . c-lineup-multi-inher)
		(inher-intro . +)
		(inlambda . c-lineup-inexpr-block)
		(inline-open . +)
		(inmodule . +)
		(innamespace . +)
		(knr-argdecl . 0)
		(knr-argdecl-intro . +)
		(label . 2)
		(lambda-intro-cont . +)
		(module-close . 0)
		(module-open . 0)
		(namespace-close . 0)
		(namespace-open . 0)
		(objc-method-args-cont . c-lineup-ObjC-method-args)
		(objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
		(objc-method-intro .
				   [0])
		(statement-case-intro . +)
		(statement-case-open . 0)
		(stream-op . c-lineup-streamop)
		(string . -1000)
		(substatement-label . 2)
		(substatement-open . +)
		(template-args-cont c-lineup-template-args +))))
(setq c-default-style "ft_style")