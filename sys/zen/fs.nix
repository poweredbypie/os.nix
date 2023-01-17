{ ... }:

{
  # This is really bad!
  # We shouldn't be referring to a home directory as a mountpoint.
  # Potential solution: Make a /docs folder? But make it rwx for the users group?
  fileSystems."/home/pie/bridge".label = "bridge";
}
