;; A Chance Cube that takes in 'sample-colors' and outputs a roll.
;; There can be as many colors and sides as you want
;; TODO: Still need to determine if it is actually random

;; Currently it is the dice combination of colors, first number is the color, second is the number of sides
(def sample-colors [["Blue" 3] ["Red" 3] ["Black" 12] ["Orange" 5]])

(defn num-sides
  [color-array]
  (reduce + (map #(second %) color-array)))

(defn cal-running-sum
  "Sums the previous numbers percent chance and adds them to the current"
  [sample]
  (let [sides (count sample)]
    (def output [])                     ;Used for the output
    (loop [i 0]
      (when (< i sides)                 ;When i is less than the number of sides
        ;; adds the current prop to the sum of the rest using a subvec 
        (def output (conj output (+ (nth sample i) (reduce + (subvec sample 0 i)))))
        (recur (inc i))))
    output))

(defn throw-cube
  "Throws the cube so to speak and gets the winning color"
  [run-total color-array]
  (let [roll (rand 1)
        cnt (count run-total)]
    (def winner "")
    (loop [x 0]
      (when (< x cnt)
        ;; Since it is a running sum the first time roll is less than the current run-total num it declares a winner
        (if (<= roll (nth run-total x))
          (def winner (nth color-array x))
          (recur (inc x)))))
    (println winner)))
             
(defn cal-prop
  "Calculates the propability of each color"
  [color-array]
  ;; num-map is the map of just the second value of the input, or the number of sides per color
  (let [num-map (map (fn [temp] (second temp)) color-array)
        ;; Sums the num map to get the total sums
        sum (reduce + num-map)
        ;; Creates the percent chance of getting that number
        percent-map (map #(/ % sum) num-map)
        ;; Creates a map of the colors
        colors (map #(first %) color-array)]
    ;; Throws the chance cube and puts the percent map into a vector
    (throw-cube (cal-running-sum (into [] percent-map)) colors)))


(defn -main
  "A chance cube with three colors"
  ; Colors should be in the form [["Blue" 2"] ["White" 1"]...
  []
  (cal-prop sample-colors))
