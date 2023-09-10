(ns workspace-activate
  (:require ["vscode" :as vscode]
            [joyride.core :as joyride]
            [meh]))

(defonce !db (atom {:disposables []}))

;; To make the activation script re-runnable we dispose of
;; event handlers and such that we might have registered
;; in previous runs.
(defn- clear-disposables! []
  (run! (fn [disposable]
          (.dispose disposable))
        (:disposables @!db))
  (swap! !db assoc :disposables []))

;; Pushing the disposables on the extension context's
;; subscriptions will make VS Code dispose of them when the
;; Joyride extension is deactivated.
(defn- push-disposable [disposable]
  (swap! !db update :disposables conj disposable)
  (-> (joyride/extension-context)
      .-subscriptions
      (.push disposable)))

(defn- main []
  (clear-disposables!)
  (push-disposable
    ;; It might surprise you to see how often and when this happens,
    ;; and when it doesn't happen.
    (vscode/workspace.onDidOpenTextDocument
      (fn [doc]
        (doto (joyride/output-channel)
          (.appendLine (str (.-languageId doc) (.-fileName doc)))))))
    (meh/main))

(when (= (joyride/invoked-script) joyride/*file*)
  (main))
