#
# The MIT License (MIT)
#
# Copyright (c) 2014 Undead Labs, LLC
#

defmodule Instrumental.OS do
  @spec hostname :: binary
  def hostname do
    {:ok, name} = :inet.gethostname
    List.to_string(name)
  end

  @spec platform :: atom
  def platform do
    {_, osname} = :os.type
    Atom.to_string(osname)
  end

  @spec pid :: binary
  def pid, do: List.to_string(:os.getpid)
end
