(ns interest-is-interesting)

(defn interest-rate
  "Given the current account balance, return the corresponding interest rate."
  [balance]
  (cond (< balance 0M) -3.213
        (< balance 1000M) 0.5
        (< balance 5000M) 1.621
        :else 2.475))

(defn annual-balance-update
  "Deposit earned interest or withdraw penalty fee from the account balance."
  [balance]
  (* balance (+ 1 (/ (abs (bigdec (interest-rate balance))) 100))))

(defn amount-to-donate
  "Calculate how much money to donate"
  [balance tax-free-percentage]
  (if (< balance 0)
    0
    (int (* balance (/ (* 2M tax-free-percentage) 100M)))))