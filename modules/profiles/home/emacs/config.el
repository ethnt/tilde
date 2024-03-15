;; Interface

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message (user-login-name))
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default
		    nil
		    :height 160
		    :family "PragmataPro Mono Liga")

(set-face-attribute 'variable-pitch
		    nil
		    :height 120
		    :family "SF Pro")


;; Enable modes

(which-key-mode)
