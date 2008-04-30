(* 
 * Number - Generic interface for numbers
 * Copyright (C) 2007 Bluestorm <bluestorm dot dylc on-the-server gmail dot com>
 *               2008 David Teller
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version,
 * with the special exception on linking described in file LICENSE.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)

(**
   The smallest set of operations supported by every set if numbers
*)
type 'a numeric =
{
    zero : 'a;
    one : 'a;
    neg : 'a -> 'a;
    succ : 'a -> 'a;
    pred : 'a -> 'a;
    abs : 'a -> 'a;
    add : 'a -> 'a -> 'a;
    sub : 'a -> 'a -> 'a;
    mul : 'a -> 'a -> 'a;
    div : 'a -> 'a -> 'a;
    modulo : 'a -> 'a -> 'a;
    pow : 'a -> 'a -> 'a;
    compare : 'a -> 'a -> int;
    of_int : int -> 'a;
    to_int : 'a -> int;
    of_string : string -> 'a;
    to_string : 'a -> string;
}

(**
   The smallest set of operations supported by every set if numbers
*)
module type NUMERIC_BASE =
  sig
    type t
      (** A type of numbers*)

    val zero : t
    val one : t

  (** {6 Arithmetic operations} 
      
      Depending on the implementation, some of these operations
      {i may} raise exceptions at run-time to represent over/under-flows.*)
    val neg : t -> t
    val succ : t -> t
    val pred : t -> t
    val abs : t -> t
    val add : t -> t -> t
    val sub : t -> t -> t
    val mul : t -> t -> t
    val div : t -> t -> t
    val modulo : t -> t -> t
    val pow : t -> t -> t
    val compare : t -> t -> int

    (** {6 Conversions} *)
  val of_int : int -> t
    (** Convert this number to the closest integer.*)

  val to_int : t -> int
    (** Convert an integer to the closest element of set [t].*)

  val of_string : string -> t
    (** Convert the representation of a number to the corresponding
	number. Raises [Invalid_arg] if the string does not represent
        a valid number of type [t]*)

    val to_string : t -> string
  end



(**
   The full set of operations of a type of numbers
*)
module type NUMERIC =
  sig
    type t

    val operations : t numeric
    val zero : t
    val one : t
    val neg : t -> t
    val succ : t -> t
    val pred : t -> t
    val abs : t -> t
    val add : t -> t -> t
    val sub : t -> t -> t
    val mul : t -> t -> t
    val div : t -> t -> t
    val modulo : t -> t -> t
    val pow : t -> t -> t
    val compare : t -> t -> int
    val of_int : int -> t
    val to_int : t -> int
    val of_string : string -> t
    val to_string : t -> string
    val ( +. ) : t -> t -> t
    val ( -. ) : t -> t -> t
    val ( *. ) : t -> t -> t
    val ( /. ) : t -> t -> t
    val ( ** ) : t -> t -> t
    val ( <>. ) : t -> t -> bool
    val ( >=. ) : t -> t -> bool
    val ( <=. ) : t -> t -> bool
    val ( >. ) : t -> t -> bool
    val ( <. ) : t -> t -> bool
    val ( =. ) : t -> t -> bool
  end

(**
   Automated definition of operators for a given numeric type.

   {@see open...in...}
*)
module Numeric :
  functor (Base : NUMERIC_BASE) ->
    sig
      type t = Base.t
      val operations : t numeric
      val zero : t
      val one : t
      val neg : t -> t
      val succ : t -> t
      val pred : t -> t
      val abs : t -> t
      val add : t -> t -> t
      val sub : t -> t -> t
      val mul : t -> t -> t
      val div : t -> t -> t
      val modulo : t -> t -> t
      val pow : t -> t -> t
      val compare : t -> t -> int
      val of_int : int -> t
      val to_int : t -> int
      val of_string : string -> t
      val to_string : t -> string
      val ( +. ) : t -> t -> t
      val ( -. ) : t -> t -> t
      val ( *. ) : t -> t -> t
      val ( /. ) : t -> t -> t
      val ( ** ) : t -> t -> t
      val ( <>. ) : t -> t -> bool
      val ( >=. ) : t -> t -> bool
      val ( <=. ) : t -> t -> bool
      val ( >. ) : t -> t -> bool
      val ( <. ) : t -> t -> bool
      val ( =. ) : t -> t -> bool
    end


exception Overflow

module Bounded :
  sig
    type t
    val min_num : t
    val max_num : t
  end

val generic_pow : zero:'a -> one:'a -> div_two:('a -> 'a) -> mod_two:('a -> 'a) -> mul:('a -> 'a -> 'a) -> 'a -> 'a -> 'a
