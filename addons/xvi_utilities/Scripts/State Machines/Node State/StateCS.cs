using Godot;

namespace DragonXVI;

/// <summary>
/// The base node for CSStates, to be used by a parent state machine.
/// </summary>
[GlobalClass, Tool, Icon("res://addons/xvi_utilities/Assets/Script Icons/state_node.atlastex")]
public abstract partial class StateCS : Node
{
    /// <summary>
    /// Emitted when this wants to change to another state.
    /// </summary>
    [Signal]
    public delegate void StateChangeRequestedEventHandler(StringName stateName);
    /// <summary>
    /// Requests a state change.
    /// </summary>
    /// <param name="stateName">Name of the state to request.</param>
    public void EmitRequestStateChange(StringName stateName)
    {
        EmitSignal(SignalName.StateChangeRequested, stateName);
    }

    public override void _Ready()
    {
        base._Ready();

        if (Engine.IsEditorHint())
        {
            XVIFuncs.DisableNodeProcesses(this);
            return;
        }
    }

    /// <summary>
    /// Called when this state gets entered.
    /// </summary>
    public virtual void _EnterState() { }
    /// <summary>
    /// Called when this state is left.
    /// </summary>
    public virtual void _LeaveState() { }
    /// <summary>
    /// Checks if switching to the new state from this one is valid.
    /// By defualt, this blocks states from switching to themselves.
    /// </summary>
    /// <param name="state">The new state we wish to enter.</param>
    /// <returns>True if switch is valid.</returns>
    public virtual bool _CanSwitchState(StateCS state)
    {
        return Name != state.Name;
    }

    /// <summary>
    /// States are enabled before they are entered.
    /// </summary>
    public virtual void _Enable()
    {
        ProcessMode = ProcessModeEnum.Inherit;
    }
    /// <summary>
    /// States are disabled when not in use.
    /// </summary>
    public virtual void _Disable()
    {
        ProcessMode = ProcessModeEnum.Disabled;
    }
}
