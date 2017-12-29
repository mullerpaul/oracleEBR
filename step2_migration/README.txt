The objects are set up, now we create some reprentative usage of those objects.
After that usage has started, we can start a migration.
The migration contains changes to both the view and the package used by the view, so
we might expect it to hang until the queires against the view have completed; but since
we are running the migration in the NEW edition, this should not be the case!
After the migration is complete, we should be able to start more usage in the new edition.
If we can do that, all that remains is to ensure all new sessions are started in the new edition.
