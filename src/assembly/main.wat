(module
  ;; Import memory
  (import "js" "memory" (memory 1))

  ;; Helper functions for better readability
  (func $log (param i32)
    (call $console_log
      (get_local 0)))

  (func $add (param $a i32) (param $b i32) (result i32)
    (i32.add
      (get_local $a)
      (get_local $b)))

  ;; Class-like structure
  (type $Point
    (struct
      (field $x i32)
      (field $y i32)))

  ;; Constructor
  (func $Point.new (param $x i32) (param $y i32) (result i32)
    (i32.store
      (i32.const 0)
      (get_local $x))
    (i32.store
      (i32.const 4)
      (get_local $y))
    (i32.const 0))

  ;; Method to get distance
  (func $Point.distance (param $point i32) (result f32)
    (local $x i32) (local $y i32)
    (set_local $x
      (i32.load
        (get_local $point)))
    (set_local $y
      (i32.load offset=4
        (get_local $point)))
    (f32.sqrt
      (f32.add
        (f32.mul
          (f32.convert_i32/s
            (get_local $x))
          (f32.convert_i32/s
            (get_local $x)))
        (f32.mul
          (f32.convert_i32/s
            (get_local $y))
          (f32.convert_i32/s
            (get_local $y))))))

  ;; Utility functions
  (func $abs (param $n i32) (result i32)
    (select
      (i32.sub
        (i32.const 0)
        (get_local $n))
      (get_local $n)
      (i32.lt_s
        (get_local $n)
        (i32.const 0))))

  (func $max (param $a i32) (param $b i32) (result i32)
    (select
      (get_local $a)
      (get_local $b)
      (i32.gt_s
        (get_local $a)
        (get_local $b))))

  ;; Export functions
  (export "add" (func $add))
  (export "Point.new" (func $Point.new))
  (export "Point.distance" (func $Point.distance))
  (export "abs" (func $abs))
  (export "max" (func $max)))
