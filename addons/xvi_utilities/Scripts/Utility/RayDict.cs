using Godot;

namespace DragonXVI;


/// <summary>
/// Constants for the dicts returned by raycasting.
/// </summary>
public static class RayDict
{
    /// <summary>
    /// The colliding object, usually a [Node2D] ([TileMapLayer] or a [CollisionObject2D])
    /// Not sure whats returned if its an object created manually with [PhysicsServer2D].
    /// </summary>
    public static readonly StringName Collider = new("collider");
	/// <summary>
    /// The colliding objects ID.
	/// Not exactly sure what this means...
    /// </summary>
    public static readonly StringName ColliderID = new("collider_id");
	/// <summary>
	/// Normal vector pointing at the collision point.
	/// Can be a zero vector if the collision happens inside a shape.
	/// </summary>
	public static readonly StringName Normal = new("normal");
	/// <summary>
	/// Global position of the collision point.
	/// </summary>
	public static readonly StringName Position = new("position");
	/// <summary>
	/// The Rid of the hit object.
	/// </summary>
	public static readonly StringName RID = new("rid");
	/// <summary>
	/// The shape index of the hit collider.
	/// </summary>
	public static readonly StringName Shape = new("shape");
}
