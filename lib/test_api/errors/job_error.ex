defprotocol Core.Errors.JobError do
  @doc "Convert job error to json encodable structure"
  def dump(error)
end
