# Backpack Mecha economy and run state

Implemented in `src/economy.ts`; checks in `tests/economy.test.ts`.

The public functions return `{ok, reason, reasonEn}`. Successful calls update the existing `Run` object, replacing its nested data. UI selections should retain item UIDs rather than item object references. Failed commands leave the entire run, including random stream positions and currency, unchanged.

## Integration conventions

- `wave` is one-based. Successful non-final battle resolution advances it before presenting rewards. Prototype ends on 4, demo on 8, full on 12. Demo/prototype use difficulty 0 and their own content pools.
- `rotation` is 0–3 quarter-turns. Corner indices are 0 top-left, 1 top-right, 2 bottom-left, 3 bottom-right.
- `run.power` is base capacity 10/12/14. Use `getCapacity()` for installed battery capacity. Stored modules have no effect. `autoPack()` rearranges equipped items, retaining spare items on the reserve rack.
- Placement may temporarily leave a support unlinked. Removing a battery may leave excess power. `startWave()` checks the complete loadout and refuses either condition. Geometrically illegal placement and power-exceeding new equipment placement are atomic failures.
- Offers retain their slot after purchase with an empty `id`. One offer may be locked; it survives refreshes and the next shop. Purchasing normally puts the item in reserve. If reserve is full, pass an explicit legal `placement`.
- A sale snapshot includes the entire shop state. Undo rolls back later purchases, upgrades, rearrangements, and refresh RNG to immediately before the latest sale. Starting battle or resolving an event ends undo availability.
- `BattleResult.stats` contains only the latest battle's increments. `stats.goldEarned` contains kill/pickup income, capped to the wave reward pool. Economy awards base survival/Boss income and route/event rewards. `BattleResult.rng`, when present, persists the combat stream.
- Boss rewards progress through `expansion → protocol → prep`. Module rewards use `reward` and may form a queue when a risk contract overlaps a scheduled reward. Taking scrap uses `chooseReward(run, -1)`.

## Event and route fields

`run.route`: 0 normal, 1 increased budget for 30 scrap, 2 elite contract for a module choice. Battle code applies the contract; economy grants the reward after a win. Route risk and event risk cannot stack.

`run.extra` fields consumed by battle:

| Field | Meaning |
| --- | --- |
| `eventBudgetBonus` | Additional budget fraction, normally 0.15 |
| `eventExtraElite` | Additional elite count, normally 1 |
| `temporaryShield` | Additional shield capacity for the next battle, normally 15 |

Economy also maintains `eventRewardGold`, `eventRewardModule`, `guaranteedSupportTag`, and `guaranteedSupportFromWave`. The latter ensures a sealed shipment affects a later shop, not refreshes of the current shop. A locked free slot defers the guarantee until it can be applied.

Event choices use 0/1 for the displayed first/second choice and -1 for leaving. For workbench and dismantler choice 0, set `run.extra.eventTargetUid` to an explicitly selected item. For sealed shipment choice 0, set `run.extra.eventTargetTag` to a tag of an equipped weapon. These choices reject missing targets instead of silently upgrading or selling an arbitrary item. A dismantled module refunds 75% of its standard purchase-plus-upgrade value; ordinary sales refund 50%.

## Executed checks

The 17 economy scenario tests cover starter legality and mode restrictions; rotated cells, locked corners, incompatible/full support links; reserve/duplicate limits; battery removal; shop category/rarity/uniqueness and independent RNG; locked offers across visits; atomic purchases; full sale rollback; damaged undo/reward journals; upgrades and repair limits; pity and deferred guarantees; complete prototype/demo/full state progression; duplicate battle/reward resolution; all eight events; overlapping rewards; and three demo-capable build layouts.

The demo build fixtures fit 23 unlocked cells, 12 base power plus optional battery, tier-II ceilings, and the conservative 399.4 scrap available before the second Boss. Costs include standard purchase and upgrade costs and do not subtract starter or free reward value.

## Storage and cross-system verification

`tests/storage.test.ts` adds 10 tests for independent fresh profiles; JSON-safe save round trips and timestamps; preserving permanent progress across unknown save versions; profile sanitization; rejecting incomplete run state and unknown content IDs; recovering an unfinished loadout; restoring the complete runtime battle state; falling back to preparation for an incomplete/mismatched battle snapshot; and unavailable IndexedDB behavior.

`tests/integration.test.ts` adds 7 tests:

- **Actual combat simulation:** the first normal wave uses `createBattle()` and `stepBattle()` with ordinary movement, dash and overdrive inputs. The world is never forced to win. Seed `integration-first-wave` reaches the actual 40-second survival condition, then `battleResult()` is applied through economy exactly once.
- **Actual snapshot continuation:** a populated combat snapshot at approximately 10 seconds is serialized through JSON and `sanitizeSave()`, then resumed with the same inputs. Its entities, state, RNG and final result match uninterrupted simulation.
- **Actual overdrive input:** after a real first-wave win, 42 seconds of second-wave simulation triggers automatic overdrive three times, while a held manual input triggers once.
- **State-machine fixtures:** prototype/demo/full campaign progression uses explicitly constructed `BattleResult` values. These fixtures verify reward routing, upgrade gates, content pools, save/reload checkpoints and profile unlocks. They do **not** demonstrate that a player or build can defeat every wave or Boss.
- Further integration checks cover repeated preparation checkpoint reloads with a fixed seed, protocol/event modifiers reaching combat and expiring correctly, and the production `applyProgress()` unlock function.

The checks run in Node.js against pure game rules and serialized state. They do not measure rendered frame rate, input latency, touchscreen usability, or browser audio. This QA work did not test physical Android devices, iPhones/iPads, or the TikTok container. It also did not conduct a 12-person playtest or validate replay/retention targets. Separate browser, real-device, performance and player testing remains necessary before making those claims.
