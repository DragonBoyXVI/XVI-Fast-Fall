namespace DragonXVI;

/// <summary>
/// Simple match based state machine wrapper.
/// Also emits events when the state changes.
/// </summary>
public class StateMachineLite<T>
{
    public delegate void StateLiteDelegate(T state);
    /// <summary>
    /// Emitted after the state is changed.
    /// </summary>
    public event StateLiteDelegate StateEntered;
    /// <summary>
    /// Emitted before the state is changed.
    /// </summary>
    public event StateLiteDelegate StateLeft;

    /// <summary>
    /// The current state.
    /// </summary>
    public T State
    {
        get => _state;
        set
        {
            StateLeft?.Invoke(_state);
            _state = value;
            StateEntered?.Invoke(value);
        }
    }
    private T _state;
}
