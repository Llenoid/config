-- vim.filetype.add({
--     extension = {
--         yml = function(path, bufnr)
--             if path:match("docker%-compose.*%.yml$") or path:match("compose.*%.yml$") then
--                 return "yaml.docker-compose"
--             end
--             return "yaml"
--         end,
--         yaml = function(path, bufnr)
--             if path:match("docker%-compose.*%.yaml$") or path:match("compose.*%.yaml$") then
--                 return "yaml.docker-compose"
--             end
--             return "yaml"
--         end,
--     },
-- })
vim.filetype.add({
  pattern = {
    -- Matches docker-compose.yml, docker-compose.prod.yaml, etc.
    ["docker%-compose.*%.y[a]?ml"] = "yaml.docker-compose",
    -- Matches compose.yml, compose.staging.yaml, etc.
    ["compose.*%.y[a]?ml"] = "yaml.docker-compose",
  },
})
