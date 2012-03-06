Removed due to incompatibilities, encouraging of bad practice or ambiguous semantics:

- new_and_store (which should be named `ActiveRecord::Base.create_without_callbacks` but we don't know of a way to port this to Rails 3 (the port was incomplete), we can probably do it in plain SQL)
- should_not_receive_and_execute (same as should_not_receive)
- should_receive_all_with (over-generic method name for a helper that is rarely useful)
- 



