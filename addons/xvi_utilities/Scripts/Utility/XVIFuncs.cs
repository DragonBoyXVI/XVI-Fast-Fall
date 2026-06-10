using Godot;

namespace DragonXVI;

/// <summary>
/// Holds some useful fuctions.
/// </summary>
public static class XVIFuncs
{
    /// <summary>
    /// Disables all node processes that have a disable function.
    /// Such as process, physics process, input processes, etc.
    /// Useful for tool nodes, be sure to call this in _Ready rather than the constructor.
    /// </summary>
    /// <param name="node">The node to disable.</param>
    public static void DisableNodeProcesses(Node node)
	{
		node.SetProcess(false);
		node.SetPhysicsProcess(false);
		node.SetProcessInput(false);
		node.SetProcessShortcutInput(false);
		node.SetProcessUnhandledInput(false);
		node.SetProcessUnhandledKeyInput(false);
	}
}