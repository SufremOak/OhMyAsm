;; The OhMyAsm Framework
;; Copyright (C) 2025 SufremOak
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; This file is part of the OhMyAsm Framework.

(module $OhMyAsm
  (import "env" "memory" (memory 1))
  (import "env" "print" (func $print (param i32)))
  (import "env" "print_i64" (func $print_i64 (param i64)))
  (import "env" "print_f32" (func $print_f32 (param f32)))
  (import "env" "print_f64" (func $print_f64 (param f64)))
  (import "env" "print_str" (func $print_str (param i32) (param i32)))
  ;; Importing the memory for the module
  (memory $mem 1)
  ;; Exporting the memory for external access
  (export "memory" (memory $mem))
  func $print_string (param $str_ptr i32) (param $str_len i32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
)
;; Function to print an integer
((func $print_int (param $value i32)
  ;; Call the print function with the integer value
  call $print
)
;; Function to print a 64-bit integer
(func $print_int64 (param $value i64)
  ;; Call the print_i64 function with the 64-bit integer value
  call $print_i64
)
;; Function to print a 32-bit float
(func $print_float32 (param $value f32)
  ;; Call the print_f32 function with the 32-bit float value
  call $print_f32
)
;; Function to print a 64-bit float
(func $print_float64 (param $value f64)
  ;; Call the print_f64 function with the 64-bit float value
  call $print_f64
)
;; Function to print a string with a newline
(func $print_string_newline (param $str_ptr i32) (param $str_len i32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Print a newline character
  call $print_string
)
;; Function to print a string with a newline and an integer
(func $print_string_int (param $str_ptr i32) (param $str_len i32) (param $value i32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print function with the integer value
  call $print
)
;; Function to print a string with a newline and a 64-bit integer
(func $print_string_int64 (param $str_ptr i32) (param $str_len i32) (param $value i64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_i64 function with the 64-bit integer value
  call $print_i64
)
;; Function to print a string with a newline and a 32-bit float
(func $print_string_float32 (param $str_ptr i32) (param $str_len i32) (param $value f32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f32 function with the 32-bit float value
  call $print_f32
)
;; Function to print a string with a newline and a 64-bit float
(func $print_string_float64 (param $str_ptr i32) (param $str_len i32) (param $value f64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f64 function with the 64-bit float value
  call $print_f64
)
;; Function to print a string with a newline and a 32-bit integer
(func $print_string_int32 (param $str_ptr i32) (param $str_len i32) (param $value i32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print function with the integer value
  call $print
)
;; Function to print a string with a newline and a 64-bit integer
(func $print_string_int64 (param $str_ptr i32) (param $str_len i32) (param $value i64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_i64 function with the 64-bit integer value
  call $print_i64
)
;; Function to print a string with a newline and a 32-bit float
(func $print_string_float32 (param $str_ptr i32) (param $str_len i32) (param $value f32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f32 function with the 32-bit float value
  call $print_f32
)
;; Function to print a string with a newline and a 64-bit float
(func $print_string_float64 (param $str_ptr i32) (param $str_len i32) (param $value f64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f64 function with the 64-bit float value
  call $print_f64
)
;; Function to print a string with a newline and a 32-bit integer
(func $print_string_int32 (param $str_ptr i32) (param $str_len i32) (param $value i32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print function with the integer value
  call $print
)
;; Function to print a string with a newline and a 64-bit integer
(func $print_string_int64 (param $str_ptr i32) (param $str_len i32) (param $value i64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_i64 function with the 64-bit integer value
  call $print_i64
)
;; Function to print a string with a newline and a 32-bit float
(func $print_string_float32 (param $str_ptr i32) (param $str_len i32) (param $value f32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f32 function with the 32-bit float value
  call $print_f32
)
;; Function to print a string with a newline and a 64-bit float
(func $print_string_float64 (param $str_ptr i32) (param $str_len i32) (param $value f64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f64 function with the 64-bit float value
  call $print_f64
)
;; Function to print a string with a newline and a 32-bit integer
(func $print_string_int32 (param $str_ptr i32) (param $str_len i32) (param $value i32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print function with the integer value
  call $print
)
;; Function to print a string with a newline and a 64-bit integer
(func $print_string_int64 (param $str_ptr i32) (param $str_len i32) (param $value i64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_i64 function with the 64-bit integer value
  call $print_i64
)
;; Function to print a string with a newline and a 32-bit float
(func $print_string_float32 (param $str_ptr i32) (param $str_len i32) (param $value f32)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f32 function with the 32-bit float value
  call $print_f32
)
;; Function to print a string with a newline and a 64-bit float
(func $print_string_float64 (param $str_ptr i32) (param $str_len i32) (param $value f64)
  ;; Call the print_str function with the string pointer and length
  call $print_str
  ;; Call the print_f64 function with the 64-bit float value
  call $print_f64
))