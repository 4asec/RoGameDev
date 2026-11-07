# WARGA PARTY — TECHNICAL LIMITATIONS & ENGINE BUDGETS
**Document Version:** 1.0.0  
**Scope:** Roblox Engine Performance Caps, MCP Integration Boundaries & Asset Hygiene  

---

## 1. PERFORMANCE & RESOURCE BUDGETS

To guarantee a steady **60 FPS** across mobile phones (iOS/Android mid-range) and entry-level laptops without thermal throttling:

| Performance Metric | Hard Budget Limit | Target for Jakarta Showcase | Strategy / Mitigation |
| :--- | :--- | :--- | :--- |
| **Total Instance Count** | Max 3,000 instances | **1,400 - 1,800 instances** | Use modular MeshParts; eliminate micro-detail primitive part clusters. |
| **Total Triangles / Polygons** | Max 350,000 tris | **180,000 - 240,000 tris** | Prioritize low-poly stylized meshes with clean topology. |
| **Draw Calls** | Max 800 draw calls | **350 - 500 draw calls** | Take advantage of Roblox automatic mesh instancing for identical streetlights, trees, and road tiles. |
| **Client Memory (RAM)** | Max 500 MB | **< 280 MB** | Use shared 512x512 / 1024x1024 texture atlases; avoid 4K textures. |
| **Physics Simulation** | Max 100 moving bodies | **< 15 moving bodies** | 100% of environment buildings, roads, and props are `Anchored = true`. Only active player rigs move. |
| **Collision Calculations** | Default geometry | **CanCollide = false on background**| Disable collisions on decorative background skyscrapers, tree foliage, and street clutter. |

---

## 2. ROBLOX STUDIO MCP CAPABILITY MATRIX

Understanding the precise technical capabilities and limitations of our Google Antigravity IDE <-> Roblox Studio MCP bridge is essential to prevent workflow deadlocks:

```
+-----------------------------------------------------------------------------------+
|                        ROBLOX STUDIO MCP CAPABILITIES                             |
+-----------------------------------------------------------------------------------+
| [ FULLY AUTOMATED VIA MCP ]                       | [ REQUIRES MANUAL / EXTERNAL] |
| - Query game tree & inspect instances             | - High-poly 3D sculpt & UV    |
| - Search Creator Store for models & meshes        | - Upload local .fbx from disk |
| - Insert vetted models via Asset ID               | - Hand-painted texture author |
| - Batch CFrame grid positioning & snapping        | - Real-time artist terrain    |
| - Anchor, collision group, layer management       |   brush sculpting             |
| - Lighting, Atmosphere, ColorCorrection setup     | - Sound design / Audio mixing |
| - Luau script creation, refactor & execution      |                               |
+-----------------------------------------------------------------------------------+
```

### What MCP Executes Flawlessly:
1. **Asset Insertion (`insert_asset`):** Can programmatically pull any free model from the Creator Store using its verified numeric Asset ID directly into `Workspace` or `ServerStorage`.
2. **Deterministic Layout Scripting (`execute_luau`):** Can snap modular road segments and building meshes onto precise coordinate grids (e.g. 16-stud or 8-stud intervals) with zero human placement error.
3. **DataModel Inspection & Sanitation:** Can traverse inserted models, identify foreign scripts, and systematically remove unwanted scripts or GUI objects before assembling them into the active game world.
4. **Lighting & Post-Processing:** Can precisely configure `Lighting.Technology = Enum.Technology.Future`, set `Atmosphere`, `BloomEffect`, `ColorCorrection`, and `SunRays` to exact artistic RGB and density values.

### Boundaries Where MCP Cannot Replace DCC Tools (Blender):
1. **Custom Mesh Modeling:** MCP cannot sculpt a custom 3D mesh (like an authentic Monas obelisk or customized cartoon Bajaj) out of thin air. It can only assemble pre-existing assets or generate basic primitive parts.
2. **Local Mesh File Ingestion:** Without configured Roblox Open Cloud API credentials or manual import via the Roblox Studio Asset Manager, local `.fbx` or `.obj` files on the user's hard drive cannot be injected directly into the live DataModel by MCP.

---

## 3. BLENDER PIPELINE FOR MISSING ASSETS

For assets with strong Indonesian cultural specificity that do not exist with suitable stylized cartoon quality on the Creator Store, the following external DCC pipeline is established:

### Missing Assets Requiring Custom Blender Work:
1. **Monas Obelisk Stylized (Height: 110 studs):**
   - Clean quadrangular obelisk base (Cawan Monas) with a low-poly stylized flame of independence.
   - Chamfered edges for cartoon bounce lighting.
2. **Warga Party Custom Board Tile Pedestals (8 x 0.8 x 8 studs):**
   - Rounded stone paving slab with embedded glowing LED glyph slots.
3. **Gerobak Tenda Pecel Lele Stylized (Low-poly):**
   - Stylized cartoon proportions with custom banner decals.

### Export & Import Standards:
- **Format:** `.fbx` (Scale Factor: 0.01 / Centimeters to Meters match for Roblox).
- **Origin / Pivot:** Pivot point set at the exact bottom center `(X=0, Y=0, Z=0)` of the mesh for automatic grid alignment.
- **PBR Textures:** BaseColor and Roughness packed into a single 1024x1024 texture atlas.

---

## 4. THIRD-PARTY ASSET SANITIZATION PROTOCOL

To ensure the codebase remains 100% clean and free from backdoors, virus injectors, or malicious `require()` exploits, every asset pulled via `insert_asset` must pass through the automated sanitation routine:

```luau
-- Automated Sanitization Pipeline for Inserted Assets
local function sanitizeInsertedModel(targetModel: Instance)
    assert(targetModel, "Target model required")
    
    local removedCount = 0
    for _, desc in ipairs(targetModel:GetDescendants()) do
        -- 1. Strip all unapproved executable code
        if desc:IsA("LuaSourceContainer") then -- Script, LocalScript, ModuleScript
            desc:Destroy()
            removedCount += 1
        -- 2. Strip hidden backdoors and legacy infectors
        elseif desc:IsA("Fire") or desc:IsA("Smoke") or desc:IsA("Sparkles") then
            desc:Destroy()
        -- 3. Strip rogue viewport GUIs or spam decald
        elseif desc:IsA("ScreenGui") or desc:IsA("BillboardGui") then
            desc:Destroy()
        -- 4. Enforce Anchor & Optimize Physics
        elseif desc:IsA("BasePart") then
            desc.Anchored = true
            desc.CastShadow = true
        end
    end
    print(string.format("[Sanitizer] Cleaned %s: removed %d unauthorized scripts/objects.", targetModel.Name, removedCount))
end
```
